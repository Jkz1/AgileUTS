import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Konversi extends StatefulWidget {
  const Konversi({super.key});

  @override
  State<Konversi> createState() => _KonversiState();
}

class _KonversiState extends State<Konversi> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Lukman Hakim"),
    );
  }
}


// disini gak perlu buat scaffold lagi. Logikanya nanti di home.dart itu, isi body dari scaffoldnya itu dinamis. nanti itu yang diganti ganti, jadi scaffold cuma ada di konversi. lebih jelas liat aja sendiri di home.dart.