import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() => runApp(const SMSVerificationApp());

class SMSVerificationApp extends StatelessWidget {
  const SMSVerificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SMSVerificationPage(),
    );
  }
}

class SMSVerificationPage extends StatefulWidget {
  const SMSVerificationPage({super.key});

  @override
  State<SMSVerificationPage> createState() => _SMSVerificationPageState();
}

class _SMSVerificationPageState extends State<SMSVerificationPage> {
  String otpCode = "";
  late final SmsAutoFill smsController;

  @override
  void initState() {
    super.initState();
    initSmsController();
  }

  void initSmsController() async {
    smsController = SmsAutoFill();
    await getAppSignatureID();
    listenOtp();
  }

  Future<void> getAppSignatureID() async {
    var appSignatureID = await smsController.getAppSignature;
    if (kDebugMode) {
      print("appSignatureID -- $appSignatureID");
    }
  }

  Future<void> listenOtp() async {
    smsController.listenForCode();

    // This code is for extracting the code when a separate custom ui is used without using the input in sms_autofill.
    smsController.code.listen((code) {
      if (kDebugMode) {
        print("SMS Code: $code");
      }
    });
  }

  @override
  void dispose() {
    smsController.unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // #title
              const Text(
                'SMS Verification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              
              // #instructions
              Text(
                'Please enter the 6-digit code sent to your phone number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32.0),
              
              // #sms_code_input
              Center(
                child: PinFieldAutoFill(
                  currentCode: otpCode,
                  codeLength: 6,
                  onCodeChanged: (code) {
                    if (kDebugMode) {
                      print("on CodeChanged called $code");
                    }
                    otpCode = code.toString();
                    setState(() {});
                  },
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder: PinListenColorBuilder(Colors.blue.shade300, Colors.black26),
                    bgColorBuilder: const FixedColorBuilder(Colors.white),
                    strokeWidth: 1,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              
              // #verify_button
              ElevatedButton(
                onPressed: () {
                  // SMS verification action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              
              // #resend_sms_link
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Resend',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Resend SMS action
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
