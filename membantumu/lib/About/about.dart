import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../Dasar/dasar_provider.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<dasarProvider>(context);
    return Column(
      children: prov.history.map((e) => Text(e)).toList(),
    );
  }
}