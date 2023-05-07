import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class KonversiMataUang extends StatefulWidget {
  const KonversiMataUang({super.key});

  @override
  State<KonversiMataUang> createState() => _KonversiMataUangState();
}

class _KonversiMataUangState extends State<KonversiMataUang> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  String localCurrency = "IDR";
  String fromCurrency = "USD";
  String toCurrency = "IDR";
  Map<String, dynamic>? currencies;
  bool isLoading = false;

  Future<void> getCurrencies() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'),
    );

    if (response.statusCode == 200) {
      setState(() {
        currencies = json.decode(response.body)['rates'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load currencies');
    }
  }

  final currenciesMap = {
    "USD": "US Dollar",
    "EUR": "Euro",
    "JPY": "Japanese Yen",
  };

  @override
  void initState() {
    toController.text = "-";
    super.initState();
    getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Column(
            children: [
              Text("Mata Uang: $localCurrency"),
              if (isLoading) const CircularProgressIndicator(),
              if (!isLoading)
                Column(
                  children: currenciesMap.entries.map((entry) {
                    final currencyCode = entry.key;
                    final currencyName = entry.value;
                    final rate =
                        currencies![toCurrency]! / currencies![currencyCode]!;
                    final formattedRate = NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp ',
                      decimalDigits: 2,
                    ).format(rate);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(currencyName),
                            Text(
                              formattedRate,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
          const SizedBox(height: 16.0),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            const Text('Dari:'),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: fromController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Jumlah',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                DropdownButton<String>(
                  value: fromCurrency,
                  items: currencies?.keys
                      .map<DropdownMenuItem<String>>((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(key),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      fromCurrency = value!;
                      getCurrencies();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        String tempCurrency = fromCurrency;
                        fromCurrency = toCurrency;
                        toCurrency = tempCurrency;

                        fromController.clear();
                        toController.text = "-";

                        getCurrencies();
                      });
                    },
                    child: const Text("<>"))
              ],
            ),
            const SizedBox(height: 16.0),
            const Text('Ke:'),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: toController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.0),
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
                const SizedBox(width: 8.0),
                DropdownButton<String>(
                  value: toCurrency,
                  items: currencies?.keys
                      .map<DropdownMenuItem<String>>((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(key),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      toCurrency = value!;
                      getCurrencies();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (fromController.text.isEmpty) {
                      showNotif("Jumlah nilai konversi harus diisi", context);
                    } else {
                      setState(() {
                        double fromValue = double.parse(fromController.text);
                        double toValue = fromValue *
                            currencies![toCurrency]! /
                            currencies![fromCurrency]!;
                        toController.text = NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: "$toCurrency ",
                          decimalDigits: 2,
                        ).format(toValue);
                      });
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
