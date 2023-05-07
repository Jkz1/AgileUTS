import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:membantumu/Dasar/dasar_provider.dart';
import 'package:provider/provider.dart';

class Dasar extends StatefulWidget {
  const Dasar({super.key});

  @override
  State<Dasar> createState() => _DasarState();
}

class _DasarState extends State<Dasar> {

  TextStyle boldstyle(){
      return const TextStyle(fontSize: 25);
  }
  TextStyle fadestyle(){
      return const TextStyle(fontSize: 20, color: Colors.grey);
  }

  bool status = true;

  List<String>symbol = ['x','-','+','/'];

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<dasarProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12.0),
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
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      status = true;
                    });
                  },
                  child: Text(prov.txt, style: status? boldstyle():fadestyle(),overflow: TextOverflow.visible,)),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    status = false;
                  });
                },
                child: Text("= ${prov.hasil}", style: status? fadestyle():boldstyle(),))
            ]
          ),
          Column(
            children: [
              Divider(height: 2, color: Colors.grey.shade400,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: prov.fulloperation.isEmpty? null :(){
                      if(prov.txt.length == 1){
                        prov.settxt = "";
                        prov.sethasil = 0;
                      }
                      else if(symbol.contains(prov.txt[prov.txt.length-2])){
                        prov.settxt = prov.txt.substring(0, prov.txt.length-3);
                        prov.setfullop = prov.txt.split(" ");
                        prov.hitung();
                      }
                      else{
                        prov.settxt = prov.txt.substring(0, prov.txt.length-1);
                        prov.setfullop = prov.txt.split(" ");
                        prov.hitung();
                      }
                    },
                    icon: Icon(Icons.undo, size: 21,)),
                  IconButton(
                    onPressed: prov.fulloperation.isEmpty?null:
                    symbol.contains(prov.fulloperation.last)?null:(){
                      prov.settxt = prov.txt + " / ";
                      prov.setfullop = prov.txt.split(" ");
                    },
                    icon: const Text(" / ", style: TextStyle(fontSize: 21))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "1";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("1", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "2";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("2", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "3";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("3", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: prov.fulloperation.isEmpty?null:
                    symbol.contains(prov.fulloperation.last)?null:(){
                      prov.settxt = prov.txt + " x ";
                      prov.setfullop = prov.txt.split(" ");
                    },
                    icon: const Text(" x ", style: TextStyle(fontSize: 21))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "4";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("4", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "5";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("5", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "6";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("6", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      if(prov.fulloperation.isEmpty){
                        prov.settxt = prov.txt + "-";
                        prov.setfullop = ["0","-",""];
                      }else{
                        prov.settxt = prov.txt + " - ";
                        prov.setfullop = prov.txt.split(" ");
                      }
                    },
                    icon: const Text(" - ", style: TextStyle(fontSize: 21))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "7";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("7", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "8";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("8", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "9";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("9", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: prov.fulloperation.isEmpty?null:
                    symbol.contains(prov.fulloperation.last)?null:(){
                      prov.settxt = prov.txt + " + ";
                      prov.setfullop = prov.txt.split(" ");
                    },
                    icon: const Text(" + ", style: TextStyle(fontSize: 21))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + ".";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text(",", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + "0";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text("0", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      prov.settxt = prov.txt + ".";
                      prov.setfullop = prov.txt.split(" ");
                      prov.hitung();
                    },
                    icon: const Text(",", style: TextStyle(fontSize: 21))),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        status = false;
                      });
                    },
                    icon: const Text(" = ", style: TextStyle(fontSize: 21))),
                ],
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}