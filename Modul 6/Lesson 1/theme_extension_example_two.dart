import 'package:flutter/material.dart';

void main() => runApp(const LessonApp());

class LessonApp extends StatelessWidget {
  const LessonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: const <ThemeExtension>[
          CustomButtonStyle(
            backgroundColor: Colors.blue,
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Button Example')),
      body: Center(
        child: CustomButton(
          label: 'On Tap',
          onPressed: () {},
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final customButtonStyle = Theme.of(context).extension<CustomButtonStyle>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: customButtonStyle?.backgroundColor,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: customButtonStyle?.textStyle,
      ),
    );
  }
}

class CustomButtonStyle extends ThemeExtension<CustomButtonStyle> {
  const CustomButtonStyle({
    required this.backgroundColor,
    required this.textStyle,
  });

  final Color? backgroundColor;
  final TextStyle? textStyle;

  @override
  CustomButtonStyle copyWith({Color? backgroundColor, TextStyle? textStyle}) {
    return CustomButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  CustomButtonStyle lerp(ThemeExtension<CustomButtonStyle>? other, double t) {
    if (other is! CustomButtonStyle) return this;
    return CustomButtonStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }
}
