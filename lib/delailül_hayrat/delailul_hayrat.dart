import 'package:DelaliSerif/iki_gu%CC%88nde_hatim/dart/iki_gunde_hatim_kisimlar.dart';
import 'package:DelaliSerif/u%CC%88c_gu%CC%88nde_hatim/uc_gunde_hatim.dart';
import 'package:flutter/material.dart';

import '../dort_gunde_hatim/dart/dort_gunde_hatim.dart';
import '../yedi_gunde_hatim/yedi_gunde_hatim.dart';
import 'baslabgic_duasi.dart';
import 'hergun_okunacak_dua.dart';

class DelailulHayrat extends StatelessWidget {
  List<Widget> pages = [
    BaslangicDuasi(),
    IkiGundeHatim(),
    UcGundeHatim(),
    DortGundeHatim(),
    YediGundeHatim(),
    HerGunOkunacakDua(),
  ];
  List<String> title = [
    "Başlangıç Duası",
    "2 Günde Hatim",
    "3 Günde Hatim",
    "4 Günde Hatim",
    "7 Günde Hatim",
    "Her gün okunacak dua",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          title: Text("Delailül Hayrat",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
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
