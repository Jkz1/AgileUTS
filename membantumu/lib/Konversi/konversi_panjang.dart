import 'package:flutter/material.dart';

class KonversiPanjang extends StatefulWidget {
  const KonversiPanjang({super.key});

  @override
  State<KonversiPanjang> createState() => _KonversiPanjangState();
}

class _KonversiPanjangState extends State<KonversiPanjang> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  String itemSelectedUnitFrom = "Meter - m";
  List itemsUnitFrom = [
    // "Pilih Unit Sumber",
    "Kilometer - km",
    "Meter - m",
    "Desimeter - dm",
    "Sentimeter - cm",
    "Milimeter - mm"
  ];

  String itemSelectedUnitTo = "Sentimeter - cm";
  List itemsUnitTo = [
    // "Pilih Unit Tujuan",
    "Kilometer - km",
    "Meter - m",
    "Desimeter - dm",
    "Sentimeter - cm",
    "Milimeter - mm"
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
                            double unitToValue = convertPanjang(
                                double.parse(fromController.text),
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

  double convertPanjang(double value, String fromUnit, String toUnit) {
    // Konversi nilai ke satuan Meter - m
    double fromValue = 0;
    if (fromUnit == 'Kilometer - km') {
      fromValue = value * 1000;
    } else if (fromUnit == 'Meter - m') {
      fromValue = value;
    } else if (fromUnit == 'Desimeter - dm') {
      fromValue = value / 10;
    } else if (fromUnit == 'Sentimeter - cm') {
      fromValue = value / 100;
    } else if (fromUnit == 'Milimeter - mm') {
      fromValue = value / 1000;
    }

    // Konversi dari satuan Meter - m ke satuan tujuan
    double resultValue = 0;
    if (toUnit == 'Kilometer - km') {
      resultValue = fromValue / 1000;
    } else if (toUnit == 'Meter - m') {
      resultValue = fromValue;
    } else if (toUnit == 'Desimeter - dm') {
      resultValue = fromValue * 10;
    } else if (toUnit == 'Sentimeter - cm') {
      resultValue = fromValue * 100;
    } else if (toUnit == 'Milimeter - mm') {
      resultValue = fromValue * 1000;
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
