import 'package:flutter/material.dart';
import 'package:my_otp_screen/services/auth_services.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Signout'),
          onPressed: () {
            AuthServices().signOut();
          },
        ),
      ),
    );
  }
}
