import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainLoading {
  MainLoading._();

  static Widget get mainLoading {
    return Center(
      child: Lottie.asset("assets/lottie/Snitch.json",width: 150, height: 150),
    );
  }
}