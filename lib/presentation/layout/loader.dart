import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: CircularProgressIndicator(
          color: Color(0xFF2EB494),
        ),
      ),
    );
  }
}