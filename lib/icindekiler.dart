import 'package:flutter/material.dart';
import 'package:DelaliSerif/Istigfarat/dart/istigfar.dart';
import 'package:DelaliSerif/hizbulAzam/hizbul_azam.dart';
import 'package:DelaliSerif/hizbulVikaye/hizbul_vikaye.dart';
import 'package:DelaliSerif/hizbul_gayat/hizbul_gayat_icindekiler.dart';
import 'package:DelaliSerif/izahat/izahat.dart';

import 'delailül_hayrat/delailul_hayrat.dart';
import 'delali_serif/delali_serif.dart';
import 'esmaul_husna/esmaul_husna.dart';
import 'esmaul_nebi/esmaul.nebi.dart';

class ContentsScreen extends StatelessWidget {
  List<String> title = [
    "İzahat",
    "Delali-Şerif",
    "Esmaül-Hüsna",
    "Esmaül-Nebi",
    "Delailül Hayrat",
    "Hizbul-Azam",
    "İstiğfarat",
    "Hizbul-Vikaye",
    "Hizbul-Gayat",
  ];

  List<Widget> pages = [
    Izahat(),
    DelaliSerif(),
    EsmaulHusna(),
    EsmaulNebi(),
    DelailulHayrat(),
    HizbulAzam(),
    Istigfarat(),
    HizbulVikaye(),
    HizbulGayat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "İçindekiler",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.grey)],
                          gradient: LinearGradient(colors: [
                            Colors.lightGreen,
                            Colors.green,
                          ]),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            title[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
