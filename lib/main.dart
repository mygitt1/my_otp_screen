import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_otp_screen/services/auth_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: AuthServices().handleAuthentication(),
    );
  }
}
