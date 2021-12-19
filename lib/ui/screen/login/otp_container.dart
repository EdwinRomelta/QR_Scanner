import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/ui/widget/error_bottom_sheet.dart';

import 'login_screen.dart';

class OTPContainer extends StatefulWidget {
  OTPContainer({Key? key}) : super(key: key);

  @override
  State<OTPContainer> createState() => _OTPContainerState();
}

class _OTPContainerState extends State<OTPContainer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String phoneNumber;
  late String verificationId;

  @override
  void initState() {
    super.initState();
    final loginModel = context.read<LoginModel>();
    phoneNumber = loginModel.phoneNumber;
    verificationId = loginModel.verificationId;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Input 6 digit code otp which already send to $phoneNumber'),
        TextFormField(
          decoration: const InputDecoration(labelText: "OTP Code"),
          keyboardType: TextInputType.number,
          onChanged: (otp) => context.read<LoginModel>().updateOtp(otp),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 6,
        ),
        Selector<LoginModel, String>(
          selector: (context, model) => model.otp,
          builder: (context, otp, _) {
            return TextButton(
              onPressed:
                  otp.length >= 6 ? () => _submitOtp(context, otp) : null,
              child: const Text('Login'),
            );
          },
        ),
      ],
    );
  }

  void _submitOtp(BuildContext context, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
        message = e.message;
      }
      ErrorBottomSheet.show(context, message);
    }
  }
}
