import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';  //Alp1071

class HizbulAzamCuma extends StatefulWidget {
  @override
  _HizbulAzamCumaState createState() => _HizbulAzamCumaState();
}

class _HizbulAzamCumaState extends State<HizbulAzamCuma>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _pageNumbers = [
      "234",
      "235",
      "236",
      "237",
      "238",
      "239",
      "240",
      "241",
      "242",
      "243",
      "244",
      "245",
      "246",
      "247",
      "248",
      "249",
    ];
    _pageNumbers.first;
    _pageImages = [
      "234.jpg",
      "235.jpg",
      "236.jpg",
      "237.jpg",
      "238.jpg",
      "239.jpg",
      "240.jpg",
      "241.jpg",
      "242.jpg",
      "243.jpg",
      "244.jpg",
      "245.jpg",
      "246.jpg",
      "247.jpg",
      "248.jpg",
      "249.jpg",
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
        title: Text("Hizbul Azam Cuma"),
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
                  msg: "Sadece dikey konumda ??al??????r.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0

              );
            }
            _toggleScrolling();
            print("resimler say??s?? = " + _pageImages.length.toString());
            print("sayfa say??s?? = " + _pageNumbers.length.toString());
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
                                        "${_pageNumbers[index]} / 249",
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
                            hintText: "HIZ G??R??N??Z", // ***
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    RaisedButton(
                      color: Colors.amber,
                      child: Text('Yava??',
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
                      child: Text('Orta H??zl??',
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
                      child: Text('H??zl??',
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
                      child: new Text("Kayd??rma H??z?? Ayar??",
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
                            "${_pageNumbers[index]} / 249",
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
