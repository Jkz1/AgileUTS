import 'package:flutter/material.dart';

class KonversiSistemAngka extends StatefulWidget {
  const KonversiSistemAngka({super.key});

  @override
  State<KonversiSistemAngka> createState() => _KonversiSistemAngkaState();
}

class _KonversiSistemAngkaState extends State<KonversiSistemAngka> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  String itemSelectedUnitFrom = "Binner BIN";
  List itemsUnitFrom = [
    // "Pilih Unit Sumber",
    "Binner BIN",
    "Oktal OCT",
    "Desimal DESC",
    "Heksadesimal HEX"
  ];

  String itemSelectedUnitTo = "Oktal OCT";
  List itemsUnitTo = [
    // "Pilih Unit Tujuan",
    "Binner BIN",
    "Oktal OCT",
    "Desimal DESC",
    "Heksadesimal HEX"
  ];

  bool? validValUnitFrom;
  bool? validValUnitTo;

  @override
  void initState() {
    fromController.text = "0";
    toController.text = "0";

    validValUnitFrom = true;
    validValUnitTo = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    DropdownButton(
                        items: itemsUnitFrom.map((itemUnitFrom) {
                          return DropdownMenuItem(
                              value: itemUnitFrom, child: Text(itemUnitFrom));
                        }).toList(),
                        value: itemSelectedUnitFrom,
                        onChanged: (val) {
                          setState(() {
                            itemSelectedUnitFrom = val as String;
                          });
                        }),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: TextField(
                        controller: fromController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Jumlah',
                          errorText: validValUnitFrom == true
                              ? null
                              : 'Nilai unit sumber harus diisi / tidak valid(null / 0)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    DropdownButton(
                        items: itemsUnitTo.map((itemUnitTo) {
                          return DropdownMenuItem(
                              value: itemUnitTo, child: Text(itemUnitTo));
                        }).toList(),
                        value: itemSelectedUnitTo,
                        onChanged: (val) {
                          setState(() {
                            itemSelectedUnitTo = val as String;
                          });
                        }),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: TextField(
                        controller: toController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade300, width: 1.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: 'Jumlah',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                        ),
                        enabled: false,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (itemSelectedUnitFrom == itemSelectedUnitTo) {
                          showNotif(
                              "Unit Sumber dan Unit Tujuan tidak boleh sama",
                              context);
                        } else {
                          if (fromController.text.isEmpty ||
                              fromController.text == "") {
                            setState(() {
                              validValUnitFrom = false;
                            });
                          } else {
                            setState(() {
                              validValUnitFrom = true;
                            });
                          }

                          if (validValUnitFrom == true) {
                            String unitToValue = convertSistemAngka(
                                fromController.text,
                                itemSelectedUnitFrom,
                                itemSelectedUnitTo);
                            toController.text = unitToValue.toString();
                          }
                        }
                      },
                      child: const Text("Konversi"),
                    )
                  ],
                ),
              ]),
        ],
      ),
    );
  }

  String convertSistemAngka(String value, String fromUnit, String toUnit) {
    // Konversi dari sumber ke satuan antara
    int tempValue = 0;
    if (fromUnit == 'Binner BIN') {
      // Konversi dari Binner BIN
      tempValue = int.parse(value, radix: 2);
    } else if (fromUnit == 'Oktal OCT') {
      // Konversi dari Oktal OCT
      tempValue = int.parse(value, radix: 8);
    } else if (fromUnit == 'Desimal DESC') {
      // Konversi dari Desimal DESC
      tempValue = int.parse(value);
    } else if (fromUnit == 'Heksadesimal HEX') {
      // Konversi dari Heksadesimal HEX
      tempValue = int.parse(value, radix: 16);
    }

    // Konversi dari satuan antara ke tujuan
    String resultValue = '';
    if (toUnit == 'Binner BIN') {
      // Konversi ke Binner BIN
      resultValue = tempValue.toRadixString(2);
    } else if (toUnit == 'Oktal OCT') {
      // Konversi ke Oktal OCT
      resultValue = tempValue.toRadixString(8);
    } else if (toUnit == 'Desimal DESC') {
      // Konversi ke Desimal DESC
      resultValue = tempValue.toString();
    } else if (toUnit == 'Heksadesimal HEX') {
      // Konversi ke Heksadesimal HEX
      resultValue = tempValue.toRadixString(16);
    }

    return resultValue;
  }

  void showNotif(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Notifikasi"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
