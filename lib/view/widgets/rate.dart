import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final double value;

  const Rate(this.value);

  @override
  Widget build(BuildContext context) {
    setupMethods();
  }

  Widget setupMethods() {
    return Row(
      children: [
        _getIcon(),
        SizedBox(width: 18),
        _getText(),
      ],
    );
  }

  Icon _getIcon() {
    return Icon(
      Icons.favorite,
      color: Colors.red,
    );
  }

  Text _getText() {
    return Text(
      value?.toStringAsFixed(1) ?? '0.0',
      style: TextStyle(fontSize: 18),
    );
  }
}
