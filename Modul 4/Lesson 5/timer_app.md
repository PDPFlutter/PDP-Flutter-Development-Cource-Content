# Timer App

#### Step 1: Project Structure
```plaintext
lib/
│
├── main.dart                 # Entry point of the app
├── app.dart                  # Main app setup and configuration
│
├── config/                   # Configuration files
│   ├── texts.dart            # Text constants or localization
│   ├── enums.dart            # Enum definitions
│   └── colors.dart           # Color constants
│
├── component/                # UI components
│   └── buttons/
│       └── button.dart       # Custom button widgets
│
└── screen/                   # Screen-related files
    └── timer/
        ├── timer_screen.dart # Main timer screen
        ├── timer_mixin.dart  # Mixin for shared functionality
        └── component/
            └── timer_widget.dart # Custom timer widget

```

#### Step 2: Write Configuration Files

lib/config/colors.dart:
```dart
import 'dart:ui';

sealed class AppColors {
  static const pink = Color.fromRGBO(210, 71, 103, 1);
  static const deepPurple = Color.fromRGBO(66, 62, 103, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
}
```

lib/config/texts.dart:
```dart
sealed class AppTexts {
  static const appName = "Timer";
  static const start = "START";
  static const pause = "PAUSE";
  static const stop = "STOP";
  static const resume = "RESUME";
}
```

lib/config/enums.dart:
```dart
enum TimerState {
  initial,
  inProgress,
  pause,
}
```

#### Step 3: Write Components

lib/component/buttons/button.dart:
```dart
import 'package:flutter/material.dart';
import '../../config/colors.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const Button({required this.onPressed, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pink,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
```

lib/screen/timer/component/timer_widget.dart:
```dart
import 'package:flutter/material.dart';
import '../../../config/colors.dart';

class TimerWidget extends StatelessWidget {
  final String time;
  const TimerWidget({required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(50),
      decoration: const BoxDecoration(
        color: AppColors.pink,
        shape: BoxShape.circle,
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.deepPurple,
          shape: BoxShape.circle,
        ),
        child: Text(
          time,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 48,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
```

#### Step 4: Write Root Widget:

lib/main.dart:
```dart
import 'package:flutter/material.dart';
import 'app.dart';

void main() => runApp(const TimerApp());
```

lib/app.dart:
```dart
import 'package:flutter/material.dart';
import 'config/texts.dart';
import 'screen/timer/timer_screen.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTexts.appName,
      home: TimerScreen(),
    );
  }
}
```

#### Step 5: Write Code For UI and Business Logic:

lib/screen/timer/timer_mixin.dart:
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/enums.dart';
import 'timer_screen.dart';

mixin TimerMixin on State<TimerScreen> {
  Timer? timer;
  TimerState status = TimerState.initial;
  int tick = 0;

  void run() {
    setState(() {
      status = TimerState.inProgress;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        ++tick;
      });
    });
  }

  void pause() {
    setState(() {
      status = TimerState.pause;
    });
    timer?.cancel();
  }

  void stop() {
    setState(() {
      status = TimerState.initial;
      tick = 0;
    });
    timer?.cancel();
  }

  String intToTime(int tick) {
    String second = "${tick % 60}".padLeft(2, "0");
    String minute = "${(tick % 3600) ~/ 60}".padLeft(2, "0");
    String hour = "${tick ~/ 3600}".padLeft(2, "0");
    return "$hour:$minute:$second";
  }
}
```

lib/screen/timer/timer_screen.dart:
```dart
import 'package:flutter/material.dart';
import '../../component/buttons/button.dart';
import '../../config/colors.dart';
import '../../config/enums.dart';
import '../../config/texts.dart';
import '../../screen/timer/component/timer_widget.dart';
import 'timer_mixin.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with TimerMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      appBar: AppBar(
        title: const Text(
          AppTexts.appName,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: TimerWidget(time: intToTime(tick)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (status == TimerState.initial) Button(onPressed: run, title: AppTexts.start),
                  if (status == TimerState.inProgress) Button(onPressed: pause, title: AppTexts.pause),
                  if (status == TimerState.pause) Button(onPressed: stop, title: AppTexts.stop),
                  if (status == TimerState.pause) Button(onPressed: run, title: AppTexts.resume),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

