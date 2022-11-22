import 'dart:html';

import 'package:flutter/material.dart';


class BrowserNotifier extends ChangeNotifier {

  BrowserNotifier() : super() {
    window.addEventListener("popstate", (event) {
      _routePopState = window.location.pathname;
      notifyListeners();
    });
  }

  String? _routePopState;
  String? get routePopState => _routePopState;

}
