import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/ui/screen/login/login_screen.dart';
import 'package:qr_scanner/ui/widget/error_bottom_sheet.dart';
import 'package:qr_scanner/ui/widget/loading_dialog.dart';

class PhoneContainer extends StatefulWidget {
  final PhoneCodeSent phoneCodeSent;
  final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout;

  PhoneContainer({
    required this.phoneCodeSent,
    required this.phoneCodeAutoRetrievalTimeout,
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneContainer> createState() => _PhoneContainerState();
}

class _PhoneContainerState extends State<PhoneContainer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late LoginModel _loginModel;

  @override
  void initState() {
    super.initState();
    _loginModel = context.read<LoginModel>();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Input your phone number to receive 6 digit code'),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                labelText: "Phone Number", hintText: '6281234567890'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (phoneNumber) =>
                _loginModel.updatePhoneNumber(phoneNumber),
          ),
          Selector<LoginModel, String>(
            selector: (context, model) => model.phoneNumber,
            builder: (context, phoneNumber, _) {
              return TextButton(
                onPressed: phoneNumber.isNotEmpty
                    ? () => _login(context, phoneNumber)
                    : null,
                child: const Text('Send'),
              );
            },
          ),
        ],
      );

  void _login(BuildContext context, String phoneNumber) async {
    LoadingDialog.show(context);
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+$phoneNumber',
      codeSent: (String verificationId, int? forceResendingToken) {
        LoadingDialog.hide(context);
        widget.phoneCodeSent.call(verificationId, forceResendingToken);
      },
      codeAutoRetrievalTimeout: widget.phoneCodeAutoRetrievalTimeout,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        _loginModel.updateOtp(phoneAuthCredential.smsCode);
        LoadingDialog.show(context);
        await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        LoadingDialog.hide(context);
      },
      verificationFailed: (FirebaseAuthException error) {
        LoadingDialog.hide(context);
        ErrorBottomSheet.show(context, error.message);
      },
    );
  }
}
