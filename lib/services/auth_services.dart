import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_otp_screen/screens/dashboard.dart';
import 'package:my_otp_screen/screens/login_page.dart';

class AuthServices {
  handleAuthentication() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DashBoard();
        } else {
          return LoginPage();
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential credential) {
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithOtp(otpcode, verifyId) {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verifyId, smsCode: otpcode);
    signIn(authCredential);
  }
}
