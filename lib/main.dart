import 'package:flutter/material.dart';

import 'Homepage.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/": (context) => Homepage(),
    },
  ));
}
