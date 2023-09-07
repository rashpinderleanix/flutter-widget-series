

import 'package:flutter/material.dart';

class CustomBackButtonDispatcher extends RootBackButtonDispatcher {
  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) {
    print('Back button pressed');
    return super.invokeCallback(defaultValue);
  }
}
