import 'package:flutter/material.dart';

void main() => runApp(const LessonApp());

class LessonApp extends StatelessWidget {
  const LessonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        extensions: const <ThemeExtension>[
          CustomColors(
            brandColor: Color(0xFF1E88E5),
            danger: Color(0xFFFFFFFF),
          ),
        ],
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Box()),
    );
  }
}

class Box extends StatelessWidget {
  const Box({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();
    return Container(
      color: customColors?.brandColor,
      child: Text(
        'Hello World!',
        style: TextStyle(color: customColors?.danger),
      ),
    );
  }
}

class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.brandColor,
    required this.danger,
  });

  final Color? brandColor;
  final Color? danger;

  @override
  CustomColors copyWith({Color? brandColor, Color? danger}) {
    return CustomColors(
      brandColor: brandColor ?? this.brandColor,
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }
}
