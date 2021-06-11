import 'package:booking/sign-in.dart';
import 'package:flutter/material.dart';
import 'package:booking/main.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _isSignedIn = false;

    return _isSignedIn ? MapPage() : SignIn();
  }
}
