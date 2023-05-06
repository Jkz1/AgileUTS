import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class KonversiSuhu extends StatefulWidget {
  const KonversiSuhu({super.key});

  @override
  State<KonversiSuhu> createState() => _KonversiSuhuState();
}

class _KonversiSuhuState extends State<KonversiSuhu> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  String itemSelectedUnitFrom = "Celcius *C";
  List itemsUnitFrom = [
    // "Pilih Unit Sumber",
    "Celcius *C",
    "Fahrenheit *F",
    "Kelvin K",
    "Rankine *R",
    "Reaumur *Re"
  ];

  String itemSelectedUnitTo = "Fahrenheit *F";
  List itemsUnitTo = [
    // "Pilih Unit Tujuan",
    "Celcius *C",
    "Fahrenheit *F",
    "Kelvin K",
    "Rankine *R",
    "Reaumur *Re"
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
                        if (itemSelectedUnitFrom == "Pilih Unit Sumber") {
                          showNotif("Harap pilih unit sumber dahulu", context);
                        } else if (itemSelectedUnitTo == "Pilih Unit Tujuan") {
                          showNotif("Harap pilih unit tujuan dahulu", context);
                        } else if (itemSelectedUnitFrom == itemSelectedUnitTo) {
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
                            double unitToValue = convertTemperature(
                                double.parse(fromController.text),
                                itemSelectedUnitFrom,
                                itemSelectedUnitTo);

                            toController.text = unitToValue.toString();

                            // setState(() {});
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

  double convertTemperature(double value, String fromUnit, String toUnit) {
    // Konversi nilai ke satuan Celcius
    double fromValue = 0;
    if (fromUnit == 'Celcius *C') {
      fromValue = value;
    } else if (fromUnit == 'Fahrenheit *F') {
      fromValue = (value - 32) / 1.8;
    } else if (fromUnit == 'Kelvin K') {
      fromValue = value - 273.15;
    } else if (fromUnit == 'Rankine *R') {
      fromValue = (value - 491.67) * 5 / 9;
    } else if (fromUnit == 'Reaumur *Re') {
      fromValue = value * 5 / 4;
    }

    // Konversi dari sumber ke satuan tujuan
    double resultValue = 0;
    if (toUnit == 'Celcius *C') {
      resultValue = fromValue;
    } else if (toUnit == 'Fahrenheit *F') {
      resultValue = fromValue * 1.8 + 32;
    } else if (toUnit == 'Kelvin K') {
      resultValue = fromValue + 273.15;
    } else if (toUnit == 'Rankine *R') {
      resultValue = (fromValue + 273.15) * 9 / 5;
    } else if (toUnit == 'Reaumur *Re') {
      resultValue = fromValue * 4 / 5;
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
