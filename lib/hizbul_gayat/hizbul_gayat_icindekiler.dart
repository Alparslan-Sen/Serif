import 'package:flutter/material.dart';
import 'package:DelaliSerif/hizbul_gayat/hizbul_gayat.dart';

class HizbulGayat extends StatelessWidget {
  List<String> title = [
    "Hizbul-Gayat \n ( Her gün okunabilir hafta en az 1 kez )",
  ];
  List<Widget> pages = [
    HizbulGayatIcerik(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            title: Text("Hizbul Gayat",
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
