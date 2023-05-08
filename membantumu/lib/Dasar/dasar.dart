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
                      prov.setstatus = true;
                    });
                  },
                  child: Text(prov.txt, style: prov.status? boldstyle():fadestyle(),overflow: TextOverflow.visible,)),
              ),
              GestureDetector(
                onTap: prov.txt.isEmpty? null :(){
                  setState(() {
                    prov.setstatus = false;
                  });
                },
                child: Text("= ${prov.hasil}", style: prov.status? fadestyle():boldstyle(),))
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
                  OperationButton(operation: "/")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberButton(number: "1"),
                  NumberButton(number: "2"),
                  NumberButton(number: "3"),
                  OperationButton(operation: "x"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberButton(number: "4"),
                  NumberButton(number: "5"),
                  NumberButton(number: "6"),
                  IconButton(
                    onPressed: (){
                      if(prov.fulloperation.isEmpty){
                        prov.settxt = "${prov.txt}-";
                        prov.setfullop = ["0","-",""];
                      }else{
                        prov.settxt = "${prov.txt} - ";
                        prov.setfullop = prov.txt.split(" ");
                      }
                    },
                    icon: const Text(" - ", style: TextStyle(fontSize: 21))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberButton(number: "7"),
                  NumberButton(number: "8"),
                  NumberButton(number: "9"),
                  OperationButton(operation: "+"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Comma(),
                  NumberButton(number: "0"),
                  Comma(),
                  IconButton(
                    onPressed: (){
                      prov.addhistory = "${prov.txt} = ${prov.hasil}";
                      prov.seteqstatus = true;
                      setState(() {
                        prov.setstatus = false;
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


class NumberButton extends StatelessWidget {
  String number = "";
  NumberButton({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<dasarProvider>(context);
    return IconButton(
      onPressed: (){
        if(prov.equalstatus){
          prov.settxt = "";
          prov.sethasil = 0;
          prov.seteqstatus = false;
        }
        prov.setstatus = true;
        prov.settxt = prov.txt + number;
        prov.setfullop = prov.txt.split(" ");
        prov.hitung();
      },
      icon: Text(number, style: TextStyle(fontSize: 21)));
  }
}

class OperationButton extends StatelessWidget {
  String operation = "";
  OperationButton({super.key, required this.operation});


  List<String>symbol = ['x','-','+','/'];
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<dasarProvider>(context);
    return IconButton(
      onPressed: prov.fulloperation.isEmpty?null:
      symbol.contains(prov.fulloperation.last)?null:(){
        prov.setstatus = true;
        prov.settxt = "${prov.txt} ${operation} ";
        prov.setfullop = prov.txt.split(" ");
      },
      icon: Text(" ${operation} ", style: TextStyle(fontSize: 21)));
  }
}

class Comma extends StatelessWidget {
  const Comma({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<dasarProvider>(context);

    return IconButton(
      onPressed: prov.txt.isEmpty? null
      : ["1","2","3","4","5","6","7","8","9","0"].contains(prov.txt[prov.txt.length-1])
      ?(){
        prov.setstatus = true;
        prov.settxt = "${prov.txt}.";
        prov.setfullop = prov.txt.split(" ");
        prov.hitung();
      }
      : null,
      icon: const Text(",", style: TextStyle(fontSize: 21)));
  }
}