import 'package:flutter/foundation.dart';
import '../../models/user/user.dart';
import '../../service/local_service.dart';
import '../../service/network_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _loading = false;
  String? _avatarUrl;

  bool get loading => _loading;
  String? get avatarUrl => _avatarUrl;

  Future<void> uploadAvatar(String path) async {
    _loading = true;
    notifyListeners();

    final data = await Network.uploadFile(path);
    if (data != null) {
      final attachment = Network.parseAttachment(data);
      _avatarUrl = attachment.location;
    }

    _loading = false;
    notifyListeners();
  }

  Future<bool> signUp(String name, String email, String password) async {
    _loading = true;
    notifyListeners();

    final result = await Network.request(api: Apis.isAvailable, method: RequestMethod.post, data: {"email": email});
    if(result == null || Network.isAvailable(result)) {
      _loading = false;
      notifyListeners();
      return false;
    }

    const placeHolder = "https://i.imgur.com/AHXwxdw.jpeg";
    final user = User(id: 0, email: email, password: password, name: name, avatar: _avatarUrl ?? placeHolder);
    final data = await Network.request(api: Apis.users, method: RequestMethod.post, data: user.toJson());

    _loading = false;
    notifyListeners();
    return data != null;
  }

  Future<bool> login(String email, String password) async {
    _loading = true;
    notifyListeners();

    final data = await Network.request(
      api: Apis.login,
      method: RequestMethod.post,
      data: {"email": email, "password": password},
    );
    _loading = false;
    if (data != null) {
      final token = Network.parseToken(data);
      await TokenService.saveTokens(token: token);
    }

    notifyListeners();
    return data != null;
  }
}
