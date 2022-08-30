import 'package:flutter/material.dart';
import 'package:DelaliSerif/Istigfarat/dart/istigfarat_carsamba.dart';
import 'package:DelaliSerif/Istigfarat/dart/istigfarat_cuma.dart';
import 'package:DelaliSerif/Istigfarat/dart/istigfarat_cumartesi.dart';
import 'package:DelaliSerif/Istigfarat/dart/istigfarat_pazar.dart';
import 'package:DelaliSerif/Istigfarat/dart/istigfarat_pazartesi.dart';
import 'package:DelaliSerif/Istigfarat/dart/istigfarat_persembe.dart';
import 'package:DelaliSerif/Istigfarat/dart/istigfarat_sali.dart';


class Istigfarat extends StatelessWidget {
  List<String> title = [
    "Cuma",
    "Cumartesi",
    "Pazar",
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
  ];

  List<Widget> pages = [
    IstigfaratCuma(),
    IstigfaratCumartesi(),
    IstigfaratPazar(),
    IstigfaratPazartesi(),
    IstigfaratSali(),
    IstigfaratCarsamba(),
    IstigfaratPersembe(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            title: Text("Istiğfarat",
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
