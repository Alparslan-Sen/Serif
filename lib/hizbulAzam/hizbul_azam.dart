import 'package:flutter/material.dart';

import 'hizbul_azam._pazartesi.dart';
import 'hizbul_azam_baslangic_duasi.dart';
import 'hizbul_azam_carsamba.dart';
import 'hizbul_azam_cuma.dart';
import 'hizbul_azam_cumartesi.dart';
import 'hizbul_azam_pazar.dart';
import 'hizbul_azam_persembe.dart';
import 'hizbul_azam_sali.dart';

class HizbulAzam extends StatelessWidget {
  List<String> title = [
    "Başlangıç Duası",
    "Cumartesi",
    "Pazar",
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
  ];
  List<Widget> pages = [
    HizbulAzamBaslangicDuasi(),
    HizbulAzamCumartesi(),
    HizbulAzamPazar(),
    HizbulAzamPazartesi(),
    HizbulAzamSali(),
    HizbulAzamCarsamba(),
    HizbulAzamPersembe(),
    HizbulAzamCuma(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            title: Text("Hizbul Azam",
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
                      child: Text(title[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white)),
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
