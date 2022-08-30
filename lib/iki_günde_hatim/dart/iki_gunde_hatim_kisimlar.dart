import 'package:flutter/material.dart';

import 'iki_günde_hatim_birinci_kisim.dart';
import 'iki_günde_hatim_ikinci_kisim.dart';


class IkiGundeHatim extends StatelessWidget {
  List<String> title = [
    "1. Kısım",
    "2. Kısım",
  ];

  List<Widget> pages = [
    IkiGundeHatimBirinciKisim(),
    IkiGundeHatimIkinciKisim(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            title: Text("2 Günde Hatim",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
        body: ListView.builder(
            itemCount: title.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pages[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(title[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.grey)],
                      gradient: LinearGradient(colors: [
                        Colors.lightGreen,
                        Colors.green,
                      ]),
                    ),
                  ),
                ),
              );
            }));
  }
}
