import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_otp_screen/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  String contactNo, verificationId, otpCode;
  bool otpSent = false;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Enter phone number'),
                onChanged: (value) {
                  setState(() {
                    contactNo = value;
                  });
                },
              ),
            ),
            otpSent
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: 'Enter OTP'),
                      onChanged: (value) {
                        setState(() {
                          otpCode = value;
                        });
                      },
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                child: Center(
                  child: otpSent ? Text('Login') : Text('Verify'),
                ),
                onPressed: () {
                  otpSent
                      ? AuthServices().signInWithOtp(otpCode, verificationId)
                      : verifyNumber(contactNo);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyNumber(contactNo) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authResult) {
      AuthServices().signIn(authResult);
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${authException.message}');
    };
    final PhoneCodeSent phoneCodeSent = (String verifyId, [int forceResend]) {
      verificationId = verifyId;
      setState(() {
        otpSent = true;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout =
        (String verifyId) {
      verificationId = verifyId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: contactNo,
      timeout: Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
    );
  }
}
