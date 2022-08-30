import 'package:flutter/material.dart';
import 'package:DelaliSerif/dort_gunde_hatim/dart/dort_gunde_birinci_kisim.dart';
import 'package:DelaliSerif/dort_gunde_hatim/dart/dort_gunde_dorduncu_kisim.dart';
import 'package:DelaliSerif/dort_gunde_hatim/dart/dort_gunde_ikinci_kisim.dart';
import 'package:DelaliSerif/dort_gunde_hatim/dart/dort_gunde_ucuncu_kisim.dart';

class DortGundeHatim extends StatelessWidget {
  List<String> title = [
    "1. Kısım",
    "2. Kısım",
    "3. Kısım",
    "4. Kısım",
  ];

  List<Widget> pages = [
    DortGundeHatimBirinciKisim(),
    DortGundeHatimIkinciKisim(),
    DortGundeHatimUcuncuKisim(),
    DortGundeHatimDorduncuKisim(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            title: Text("4 Günde Hatim",
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
