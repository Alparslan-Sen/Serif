import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';  //Alp1071

class HizbulAzamSali extends StatefulWidget {
  @override
  _HizbulAzamSaliState createState() => _HizbulAzamSaliState();
}

class _HizbulAzamSaliState extends State<HizbulAzamSali>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _pageNumbers = [
      "201",
      "202",
      "203",
      "204",
      "205",
      "206",
      "207",
      "208",
      "209",
      "210",
      "211",
      "212",
      "213",
      "214",
    ];
    _pageNumbers.first;
    _pageImages = [
      "201.jpg",
      "202.jpg",
      "203.jpg",
      "204.jpg",
      "205.jpg",
      "206.jpg",
      "207.jpg",
      "208.jpg",
      "209.jpg",
      "210.jpg",
      "211.jpg",
      "212.jpg",
      "213.jpg",
      "214.jpg",
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
  double pageMaxSize = 0;         //Alp1071

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hizbul Azam Salı"),
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.not_started_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            //Alp1071
            if(pageMaxSize>600) {
              return  Fluttertoast.showToast(
                  msg: "Sadece dikey konumda çalışır.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0

              );
            }
            _toggleScrolling();
            print("resimler sayısı = " + _pageImages.length.toString());
            print("sayfa sayısı = " + _pageNumbers.length.toString());
          }), //
      body: LayoutBuilder(
        builder: (BuildContext context, constraints) {
          if (constraints.maxWidth < 600) {
            pageMaxSize = constraints.maxWidth; //Alp1071
            print("constraints" + constraints.toString());
            return Column(
              children: <Widget>[_createListView()],
            );
          } else {
            pageMaxSize = constraints.maxWidth; //Alp1071
            return Column(
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: _scrollController,
                    itemCount: _pageImages.length,
                    scrollDirection: Axis.horizontal, //Alp1071
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
                                    basePosition: Alignment.topCenter, //Alp1071
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
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "${_pageNumbers[index]} / 214",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: 40,
                                    child: _showDialogButton(),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ],
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

  TextEditingController speed = TextEditingController();
  Widget _showDialogButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  content: SingleChildScrollView(
                      child: Column(children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1.0)),
                      child: TextFormField(
                        controller: speed,
                        onChanged: (value) {
                          setState(() {
                            speedFactor = int.parse(speed.text);
                          });
                        },
                        onFieldSubmitted: (value) {
                          Navigator.pop(context);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "HIZ GİRİNİZ", // ***
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    RaisedButton(
                      color: Colors.amber,
                      child: Text('Yavaş',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      onPressed: () {
                        setState(() {
                          speedFactor = 3;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      color: Colors.amber,
                      child: Text('Orta Hızlı',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      onPressed: () {
                        setState(() {
                          speedFactor = 8;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      color: Colors.amber,
                      child: Text('Hızlı',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      onPressed: () {
                        setState(() {
                          speedFactor = 400;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ])),
                  title: Center(
                      child: new Text("Kaydırma Hızı Ayarı",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black))),
                ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.settings, size: 30),
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
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            "${_pageNumbers[index]} / 214",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 50,
                        child: _showDialogButton(),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
