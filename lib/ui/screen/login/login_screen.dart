import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/ui/screen/login/otp_container.dart';
import 'package:qr_scanner/ui/screen/login/phone_container.dart';

enum _LoginState { phone, otp }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginState = ValueNotifier(_LoginState.phone);
  final _loginModel = LoginModel();

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (_loginState.value == _LoginState.otp) {
            _loginState.value = _LoginState.phone;
            return false;
          }
          return true;
        },
        child: Scaffold(
          body: ChangeNotifierProvider.value(
            value: _loginModel,
            child: Container(
                padding: const EdgeInsets.all(16),
                child: ValueListenableBuilder(
                    valueListenable: _loginState,
                    builder: (context, loginState, _) {
                      switch (loginState) {
                        case _LoginState.otp:
                          return OTPContainer();
                        case _LoginState.phone:
                        default:
                          return PhoneContainer(
                            phoneCodeAutoRetrievalTimeout: (_) {
                              if(_loginState.value != _LoginState.phone) {
                                _loginState.value = _LoginState.phone;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(content: Text(
                                    'Input timeout, please reenter phone number')));
                              }
                            },
                            phoneCodeSent: (String verificationId,
                                int? forceResendingToken) {
                              _loginModel.otpSend(
                                  verificationId, forceResendingToken);
                              _loginState.value = _LoginState.otp;
                            },
                          );
                      }
                    })),
          ),
        ),
      );
}

class LoginModel with ChangeNotifier {
  String _phoneNumber = "";
  String _otp = "";
  String _verificationId = "";
  int? _resendToken;

  String get phoneNumber => _phoneNumber;

  String get otp => _otp;

  String get verificationId => _verificationId;

  int? get resendToken => _resendToken;

  void updatePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void otpSend(String verificationId, int? resendToken) {
    _verificationId = verificationId;
    _resendToken = resendToken;
    notifyListeners();
  }

  void updateOtp(String? otp) {
    _otp = otp ?? '';
    notifyListeners();
  }
}
