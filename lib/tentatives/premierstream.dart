import 'package:flutter/material.dart';

var counterStream =
    Stream<int>.periodic(Duration(seconds: 1), (x) => x).take(15);


