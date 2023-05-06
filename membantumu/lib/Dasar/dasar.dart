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
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text("12 * 12", overflow: TextOverflow.visible,),
              ),
              Text("= 24")
            ]
          ),
          Column(
            children: [
              Divider(height: 2, color: Colors.grey.shade400,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: const Text("1", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text("2", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text("3", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text(" x ", style: TextStyle(fontSize: 21))),
                ],
              ),        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: const Text("1", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text("2", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text("3", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text(" x ", style: TextStyle(fontSize: 21))),
                ],
              ),        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: const Text("1", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text("2", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text("3", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text(" x ", style: TextStyle(fontSize: 21))),
                ],
              ),        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: const Text("1", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text("2", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text("3", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){},
                    icon: const Text(" x ", style: TextStyle(fontSize: 21))),
                ],
              ),        
            ],
          ),
        ],
      ),
    );
  }
}