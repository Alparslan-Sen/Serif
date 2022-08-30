import 'package:flutter/material.dart';
import 'package:DelaliSerif/yedi_gunde_hatim/ilk_defa_pazartesi_baslayanlar_icin.dart';

import 'carsamba.dart';
import 'cuma.dart';
import 'cumartesi.dart';
import 'hatim_duasi.dart';
import 'pazar.dart';
import 'pazartesi.dart';
import 'persembe.dart';
import 'sali.dart';

class YediGundeHatim extends StatelessWidget {
  List<String> title = [
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
    "Cumartesi",
    "Pazar",
    "İlk defa pazartesi başlayacaklar için okuyacağı dua",
    "Hatim Duası",
  ];

  List<Widget> pages = [
    Pazartesi(),
    Sali(),
    Carsamba(),
    Persembe(),
    Cuma(),
    Cumartesi(),
    Pazar(),
    IlkDefaBaslayanlarIcin(),
    HatimDuasi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            title: Text("7 Günde Hatim",
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
