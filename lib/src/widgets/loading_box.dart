import 'package:flutter/material.dart';

class LoadingBox extends StatelessWidget {
  Widget build(context) {
    return ListTile(
      title: grayBox(),
      subtitle: grayBox(),
    );
  }

  Widget grayBox() {
    return Container(
      height: 10.0,
      width: 20.0,
      color: Colors.grey[300],
    );
  }
}
