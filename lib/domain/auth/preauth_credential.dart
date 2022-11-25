
import 'package:flutter/cupertino.dart';

@immutable
class PreAuthCredential {
  const PreAuthCredential({
    required this.identifier,
    required this.token,
    this.email
  });

  final String identifier;
  final String token;
  final String? email;

  PreAuthCredential addEmail(String providedEmail) {
    return PreAuthCredential(
      identifier: identifier,
      token: token,
      email: providedEmail
    );
  }
}