import 'package:flutter/material.dart';
import 'package:membantumu/Konversi/konversimatauang.dart';
import 'package:membantumu/Konversi/konversisuhu.dart';

class Konversi extends StatefulWidget {
  const Konversi({super.key});

  @override
  State<Konversi> createState() => _KonversiState();
}

class _KonversiState extends State<Konversi> {
  String itemSelectedKonversi = "Pilih Konversi";
  List itemsKonversi = [
    'Pilih Konversi',
    'Mata Uang',
    'Sistem Angka',
    'Panjang',
    'Suhu'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Pilih Fitur Konversi: "),
              DropdownButton(
                items: itemsKonversi.map((itemKonversi) {
                  return DropdownMenuItem(
                      value: itemKonversi, child: Text(itemKonversi));
                }).toList(),
                value: itemSelectedKonversi,
                onChanged: (val) {
                  setState(() {
                    itemSelectedKonversi = val as String;
                  });
                },
                disabledHint: Text(itemSelectedKonversi),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 16,
            indent: 16,
            endIndent: 16,
          ),

          // Tampilkan halaman screen sesuai dropdown
          Visibility(
            visible: itemSelectedKonversi != '',
            child: Expanded(
              child: _buildSelectedScreen(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedScreen() {
    switch (itemSelectedKonversi) {
      case 'Pilih Konversi':
        // return const Text("Silahkan Pilih Konversi");
        return const KonversiMataUang();
      case 'Mata Uang':
        return const KonversiMataUang();
      case 'Suhu':
        return const KonversiSuhu();
      default:
        return const Text('Screen belum tersedia');
    }
  }
}


// disini gak perlu buat scaffold lagi. Logikanya nanti di home.dart itu, isi body dari scaffoldnya itu dinamis. nanti itu yang diganti ganti, jadi scaffold cuma ada di konversi. lebih jelas liat aja sendiri di home.dart.