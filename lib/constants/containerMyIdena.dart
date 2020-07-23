import 'package:flutter/material.dart';

class ContainerMyIdena extends StatefulWidget {
  @override
  _ContainerMyIdenaState createState() => _ContainerMyIdenaState();
}

class _ContainerMyIdenaState extends State<ContainerMyIdena> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[600],
            Colors.grey[700],
            Colors.grey[800],
            Colors.grey[900],
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
    );
  }
}
