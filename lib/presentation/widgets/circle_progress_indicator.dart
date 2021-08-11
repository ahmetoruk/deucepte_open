import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class CicleProgressIndicator extends StatelessWidget {
  const CicleProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCircle(
      color: Colors.white,
    );
  }
}
