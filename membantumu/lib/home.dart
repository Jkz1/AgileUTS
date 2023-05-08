import 'package:flutter/material.dart';
import 'package:membantumu/About/about.dart';

import 'Dasar/dasar.dart';
import 'Konversi/konversi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _page = "Dasar";
  // ignore: non_constant_identifier_names
  int _CurrentIndex = 0;
  Widget body(BuildContext context) {
    if (_CurrentIndex == 0) {
      return home(context);
    } else if (_CurrentIndex == 1) {
      return const About();
    } else {
      return Container();
    }
  }

  Widget home(BuildContext context) {
    if (_page == "Dasar") {
      // return const Dasar();
      return const Dasar();
    } else if (_page == "Konversi") {
      return const Konversi();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Kalkulator Dasar")),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade400, width: 3)),
                  child: ListTile(
                    title: const Text("Dasar"),
                    tileColor: _CurrentIndex == 0
                        ? _page == "Dasar"
                            ? Colors.green.shade300
                            : Colors.grey.shade300
                        : Colors.grey.shade300,
                    onTap: _CurrentIndex == 0
                        ? _page == "Dasar"
                            ? null
                            : () {
                                setState(() {
                                  _CurrentIndex = 0;
                                  _page = "Dasar";
                                });
                                Navigator.pop(context);
                              }
                        : () {
                            setState(() {
                              _CurrentIndex = 0;
                              _page = "Dasar";
                            });
                            Navigator.pop(context);
                          },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade400, width: 3)),
                  child: ListTile(
                    title: const Text("Konversi"),
                    tileColor: _CurrentIndex == 0
                        ? _page == "Konversi"
                            ? Colors.green.shade300
                            : Colors.grey.shade300
                        : Colors.grey.shade300,
                    onTap: _CurrentIndex == 0
                        ? _page == "Konversi"
                            ? null
                            : () {
                                setState(() {
                                  _CurrentIndex = 0;
                                  _page = "Konversi";
                                });
                                Navigator.pop(context);
                              }
                        : () {
                            setState(() {
                              _CurrentIndex = 0;
                              _page = "Konversi";
                            });
                            Navigator.pop(context);
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _CurrentIndex,
          onTap: (idx) {
            setState(() {
              _CurrentIndex = idx;
            });
          },
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          ],
        ),
        body: body(context));
  }
}
