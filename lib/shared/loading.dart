import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Color color;
  Loading(this.color);
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitCubeGrid(color: color),
    );
  }
}
