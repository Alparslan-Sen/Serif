import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';  //Alp1071

class HerGunOkunacakDua extends StatefulWidget {
  @override
  _HerGunOkunacakDuaState createState() => _HerGunOkunacakDuaState();
}

class _HerGunOkunacakDuaState extends State<HerGunOkunacakDua>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _pageNumbers = [
      "23",
    ];
    _pageNumbers.first;
    _pageImages = [
      "23.jpg",
    ];
    _pageImages.reversed.toList();
  }

  PageController _scrollController = PageController();
  bool scroll = false;
  int speedFactor = 100;
  _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;

    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear);
  }

  _toggleScrolling() {
    setState(() {
      scroll = !scroll;
    });

    if (scroll) {
      _scroll();
    } else {
      _scrollController.animateTo(_scrollController.offset,
          duration: Duration(seconds: 1), curve: Curves.linear);
    }
  }

  List<String> _pageNumbers;
  List<String> _pageImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hergün Okunacak Dua"),
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: LayoutBuilder(
        builder: (BuildContext context, constraints) {
          if (constraints.maxWidth < 600) {
            print("constraints" + constraints.toString());
            return Column(
              children: <Widget>[_createListView()],
            );
          } else {
            return Column(
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: _scrollController,
                    itemCount: _pageImages.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: GestureDetector(
                              onTap: () async {},
                              child: Container(
                                height: 450.0,
                                child: ClipRect(
                                  child: PhotoView.customChild(
                                    initialScale: 4.0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        "assets/${_pageImages[index]}",
                                        height: 250.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget _createListView() {
    return Expanded(
      child: PageView.builder(
        controller: _scrollController,
        itemCount: _pageImages.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                flex: 8,
                child: GestureDetector(
                  onTap: () async {},
                  child: Container(
                    child: PhotoView.customChild(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/${_pageImages[index]}",
                          height: 250.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
