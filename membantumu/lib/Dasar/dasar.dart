import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Dasar extends StatefulWidget {
  const Dasar({super.key});

  @override
  State<Dasar> createState() => _DasarState();
}

class _DasarState extends State<Dasar> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Jikky"),
    );
  }
}