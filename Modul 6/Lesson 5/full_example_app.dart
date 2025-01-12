import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// lib/domain/entities/user.dart
class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
}

// lib/data/models/user_model.dart
class UserModel extends User {
  UserModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
  }
}

// lib/data/datasources/user_local_data_source.dart
abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);

  Future<UserModel?> getLastUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferencesAsync sharedPreferences;
  static const String CACHED_USER_KEY = 'CACHED_USER';

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(
      CACHED_USER_KEY,
      json.encode(user.toJson()),
    );
  }

  @override
  Future<UserModel?> getLastUser() async {
    final jsonString = await sharedPreferences.getString(CACHED_USER_KEY);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    }
    return null;
  }
}

// lib/domain/repositories/user_repository.dart
abstract class UserRepository {
  Future<void> saveUser(User user);

  Future<User?> getUser();
}

// lib/data/repositories/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveUser(User user) async {
    final userModel = UserModel(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phone: user.phone,
    );
    await localDataSource.cacheUser(userModel);
  }

  @override
  Future<User?> getUser() async {
    final user = await localDataSource.getLastUser();
    return user;
  }
}

// lib/presentation/providers/user_provider.dart
enum UserStatus { initial, loading, loaded, empty }

class UserProvider extends ChangeNotifier {
  final UserRepository repository;
  UserStatus _status = UserStatus.initial;
  User? _user;

  UserProvider({required this.repository}) {
    loadUser();
  }

  UserStatus get status => _status;

  User? get user => _user;

Future<void> saveUser({required String firstName, required String lastName, required String email, required String phone}) async {
  _status = UserStatus.loading;
  notifyListeners();

  final user = User(firstName: firstName, lastName: lastName, email: email, phone: phone);
  await repository.saveUser(user);
  _user = user;
  _status = UserStatus.loaded;
  notifyListeners();
}

Future<void> loadUser() async {
  _status = UserStatus.loading;
  notifyListeners();

  _user = await repository.getUser();
  _status = _user != null ? UserStatus.loaded : UserStatus.empty;
  notifyListeners();
}
}

// lib/presentation/pages/home_page.dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          switch (userProvider.status) {
            case UserStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case UserStatus.loaded:
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User Information', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 16),
                    UserInfoCard(user: userProvider.user!),
                  ],
                ),
              );
            case UserStatus.empty:
              return const Center(child: Text('No user information available. Please add in Profile.'));
            default:
              return Container();
          }
        },
      ),
    );
  }
}


class UserInfoCard extends StatelessWidget {
  final User user;

  const UserInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Email: ${user.email}'),
            const SizedBox(height: 4),
            Text('Phone: ${user.phone}'),
          ],
        ),
      ),
    );
  }
}

// lib/presentation/pages/profile_page.dart
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load existing user data if available
    final userProvider = context.read<UserProvider>();
    if (userProvider.status == UserStatus.loaded) {
      final user = userProvider.user!;
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Please enter first name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name', border: OutlineInputBorder()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Please enter last name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter email';
                  if (!value!.contains('@')) return 'Please enter valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<UserProvider>().saveUser(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}


// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = SharedPreferencesAsync();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferencesAsync sharedPreferences;
  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserLocalDataSource>(
          create: (_) => UserLocalDataSourceImpl(sharedPreferences: sharedPreferences),
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(localDataSource: context.read<UserLocalDataSource>()),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(repository: context.read<UserRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'User Profile App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
        },
      ),
    );
  }
}
