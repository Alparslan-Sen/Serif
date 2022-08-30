import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:DelaliSerif/widget/play_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';  //Alp1071

// Bu sayfa diğer sayfalarla uyumlu çalışabilir sadece classın ismini değiştirin
// Class ismine tıklayıp rename dediğinizde sayfa ismi değişir
// sonrasında kopylayıp diğer sayfalarda değiştirebilirsiniz
// hemen alttaki üç listeyi değiştirirmeniz yeterli
// sonrasında uyumlu çalışacaktır
// liste uzunluklarına dikkat edin kırmız ekran hatası alabilirsiniz .

class Cumartesi extends StatefulWidget {
  @override
  _CumartesiState createState() => _CumartesiState();
}

class _CumartesiState extends State<Cumartesi>
    with SingleTickerProviderStateMixin {
  String title = "Cumartesi"; // Buradan başlık değişiyor

  // 1
  List<String> imagesList = [
    // Resimlerin numarasını buradan değiştirdiğinizde o resme ait jpg gelir
    "121.jpg",
    "122.jpg",
    "123.jpg",
    "124.jpg",
    "125.jpg",
    "126.jpg",
    "127.jpg",
    "128.jpg",
    "129.jpg",
    "130.jpg",
    "131.jpg",
    "132.jpg",
    "133.jpg",
    "134.jpg",
    "135.jpg",
    "136.jpg",
  ];

  // 2
  List<String> imagesNumber = [
    // Sayfa numaralarını gösteriyor
    "121",
    "122",
    "123",
    "124",
    "125",
    "126",
    "127",
    "128",
    "129",
    "130",
    "131",
    "132",
    "133",
    "134",
    "135",
    "136",
  ];

  //3
  List<Audio> imageAudio = [
    // Sayfaya ait ses dosyaları
    Audio('mp3/121.mp3'),
    Audio('mp3/122.mp3'),
    Audio('mp3/123.mp3'),
    Audio('mp3/124.mp3'),
    Audio('mp3/125.mp3'),
    Audio('mp3/126.mp3'),
    Audio('mp3/127.mp3'),
    Audio('mp3/128.mp3'),
    Audio('mp3/129.mp3'),
    Audio('mp3/130.mp3'),
    Audio('mp3/131.mp3'),
    Audio('mp3/132.mp3'),
    Audio('mp3/133.mp3'),
    Audio('mp3/134.mp3'),
    Audio('mp3/135.mp3'),
    Audio('mp3/136.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(Icons.not_started_outlined, color: Colors.black),
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
          }), //
      body: LayoutBuilder(
        builder: (BuildContext context, constraints) {
          if (constraints.maxWidth < 600) {
            pageMaxSize = constraints.maxWidth; //Alp1071
            print("constraints" + constraints.toString());
            return Column(
              children: <Widget>[
                _createSearchView(),
                _firstSearch ? _createListView() : _performSearch(),
              ],
            );
          } else {
            pageMaxSize = constraints.maxWidth; //Alp1071
            return Column(
              children: <Widget>[
                _createSearchView(),
                _firstSearch
                    ? Expanded(
                        child: PageView.builder(
                          controller: _scrollController,
                          itemCount: imagesList.length, // ***
                          scrollDirection: Axis.horizontal, //Alp1071
                          itemBuilder: (context, index) {
                            final item = imageAudio[index];
                            return Column(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: GestureDetector(
                                    onTap: () async {
                                      try {
                                        await _assetsAudioPlayer.open(
                                          item,
                                          autoStart: true,
                                          showNotification: true,
                                          playInBackground:
                                              PlayInBackground.enabled,
                                          audioFocusStrategy:
                                              AudioFocusStrategy.request(
                                                  resumeAfterInterruption: true,
                                                  resumeOthersPlayersAfterDone:
                                                      true),
                                          headPhoneStrategy:
                                              HeadPhoneStrategy.pauseOnUnplug,
                                          notificationSettings:
                                              NotificationSettings(),
                                        );
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
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
                                              "assets/${imagesList[index]}",
                                              height: 250.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: PlayerBuilder.isPlaying(
                                    player: _assetsAudioPlayer,
                                    builder: (context, isPlaying) {
                                      return PlayingControls(
                                        pageNumber:
                                            "${imagesNumber[index]} / 136",
                                        isPlaying: isPlaying,
                                        isPlaylist: true,
                                        onPlay: () {
                                          _assetsAudioPlayer.playOrPause();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : _performSearch(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _createSearchView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _arrowBackPage(),
          _buildTextFormField(),
          _showDialogButton(),
        ],
      ),
    );
  }

  Widget _buildTextFormField() {
    return Expanded(
      child: new Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1.0)),
        child: new TextFormField(
          controller: _searchview,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 10),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: title, // ***
              hintStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Widget _createListView() {
    return Expanded(
      child: PageView.builder(
        controller: _scrollController,
        itemCount: imagesList.length, // ***
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final item = imageAudio[index]; // ***
          return Column(
            children: [
              Expanded(
                flex: 8,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await _assetsAudioPlayer.open(
                        item,
                        autoStart: true,
                        showNotification: true,
                        playInBackground: PlayInBackground.enabled,
                        audioFocusStrategy: AudioFocusStrategy.request(
                            resumeAfterInterruption: true,
                            resumeOthersPlayersAfterDone: true),
                        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                        notificationSettings: NotificationSettings(),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    child: PhotoView.customChild(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/${imagesList[index]}", // ***
                          height: 250.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PlayerBuilder.isPlaying(
                  player: _assetsAudioPlayer,
                  builder: (context, isPlaying) {
                    return PlayingControls(
                      pageNumber: "${imagesNumber[index]} / 136", // ***
                      isPlaying: isPlaying,
                      isPlaylist: true,
                      onPlay: () {
                        _assetsAudioPlayer.playOrPause();
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // -------------------------- SEARCH / SCROOL / DİALOG / FİLTER / AUDİO --------------------- //

  PageController _scrollController = PageController();
  bool _firstSearch = true;
  bool scroll = false; //
  int speedFactor = 100; // scroll hız başlangıç ayarı

  // tanımlı listeler
  List<String> _pageNumbers;
  List<String> _pageImages;
  List<String> _filterPageNumber;
  double pageMaxSize = 0;         //Alp1071

  List<Audio> audios = [
    Audio('mp3/1".mp3'),
    Audio('mp3/2".mp3'),
    Audio('mp3/3".mp3'),
    Audio('mp3/4".mp3'),
    Audio('mp3/5".mp3'),
    Audio('mp3/6".mp3'),
    Audio('mp3/7".mp3'),
    Audio('mp3/8".mp3'),
    Audio('mp3/9".mp3'),
    Audio('mp3/10.mp3'),
    Audio('mp3/11.mp3'),
    Audio('mp3/12.mp3'),
    Audio('mp3/13.mp3'),
    Audio('mp3/14.mp3'),
    Audio('mp3/15.mp3'),
    Audio('mp3/16.mp3'),
    Audio('mp3/17.mp3'),
    Audio('mp3/18.mp3'),
    Audio('mp3/19.mp3'),
    Audio('mp3/20.mp3'),
    Audio('mp3/21.mp3'),
    Audio('mp3/22.mp3'),
    Audio('mp3/23.mp3'),
    Audio('mp3/24.mp3'),
    Audio('mp3/25.mp3'),
    Audio('mp3/26.mp3'),
    Audio('mp3/27.mp3'),
    Audio('mp3/28.mp3'),
    Audio('mp3/29.mp3'),
    Audio('mp3/30.mp3'),
    Audio('mp3/31.mp3'),
    Audio('mp3/32.mp3'),
    Audio('mp3/33.mp3'),
    Audio('mp3/34.mp3'),
    Audio('mp3/35.mp3'),
    Audio('mp3/36.mp3'),
    Audio('mp3/37.mp3'),
    Audio('mp3/38.mp3'),
    Audio('mp3/39.mp3'),
    Audio('mp3/40.mp3'),
    Audio('mp3/41.mp3'),
    Audio('mp3/42.mp3'),
    Audio('mp3/43.mp3'),
    Audio('mp3/44.mp3'),
    Audio('mp3/45.mp3'),
    Audio('mp3/46.mp3'),
    Audio('mp3/47.mp3'),
    Audio('mp3/48.mp3'),
    Audio('mp3/49.mp3'),
    Audio('mp3/50.mp3'),
    Audio('mp3/51.mp3'),
    Audio('mp3/52.mp3'),
    Audio('mp3/53.mp3'),
    Audio('mp3/54.mp3'),
    Audio('mp3/55.mp3'),
    Audio('mp3/56.mp3'),
    Audio('mp3/57.mp3'),
    Audio('mp3/58.mp3'),
    Audio('mp3/59.mp3'),
    Audio('mp3/60.mp3'),
    Audio('mp3/61.mp3'),
    Audio('mp3/62.mp3'),
    Audio('mp3/63.mp3'),
    Audio('mp3/64.mp3'),
    Audio('mp3/65.mp3'),
    Audio('mp3/66.mp3'),
    Audio('mp3/67.mp3'),
    Audio('mp3/68.mp3'),
    Audio('mp3/69.mp3'),
    Audio('mp3/70.mp3'),
    Audio('mp3/71.mp3'),
    Audio('mp3/72.mp3'),
    Audio('mp3/73.mp3'),
    Audio('mp3/74.mp3'),
    Audio('mp3/75.mp3'),
    Audio('mp3/76.mp3'),
    Audio('mp3/77.mp3'),
    Audio('mp3/78.mp3'),
    Audio('mp3/79.mp3'),
    Audio('mp3/80.mp3'),
    Audio('mp3/81.mp3'),
    Audio('mp3/82.mp3'),
    Audio('mp3/83.mp3'),
    Audio('mp3/84.mp3'),
    Audio('mp3/85.mp3'),
    Audio('mp3/86.mp3'),
    Audio('mp3/87.mp3'),
    Audio('mp3/88.mp3'),
    Audio('mp3/89.mp3'),
    Audio('mp3/90.mp3'),
    Audio('mp3/91.mp3'),
    Audio('mp3/92.mp3'),
    Audio('mp3/93.mp3'),
    Audio('mp3/94.mp3'),
    Audio('mp3/95.mp3'),
    Audio('mp3/96.mp3'),
    Audio('mp3/97.mp3'),
    Audio('mp3/98.mp3'),
    Audio('mp3/99.mp3'),
    Audio('mp3/100.mp3'),
    Audio('mp3/101.mp3'),
    Audio('mp3/102.mp3'),
    Audio('mp3/103.mp3'),
    Audio('mp3/104.mp3'),
    Audio('mp3/105.mp3'),
    Audio('mp3/106.mp3'),
    Audio('mp3/107.mp3'),
    Audio('mp3/108.mp3'),
    Audio('mp3/109.mp3'),
    Audio('mp3/110.mp3'),
    Audio('mp3/111.mp3'),
    Audio('mp3/112.mp3'),
    Audio('mp3/113.mp3'),
    Audio('mp3/114.mp3'),
    Audio('mp3/115.mp3'),
    Audio('mp3/116.mp3'),
    Audio('mp3/117.mp3'),
    Audio('mp3/118.mp3'),
    Audio('mp3/119.mp3'),
    Audio('mp3/120.mp3'),
    Audio('mp3/121.mp3'),
    Audio('mp3/122.mp3'),
    Audio('mp3/123.mp3'),
    Audio('mp3/124.mp3'),
    Audio('mp3/125.mp3'),
    Audio('mp3/126.mp3'),
    Audio('mp3/127.mp3'),
    Audio('mp3/128.mp3'),
    Audio('mp3/129.mp3'),
    Audio('mp3/130.mp3'),
    Audio('mp3/131.mp3'),
    Audio('mp3/132.mp3'),
    Audio('mp3/133.mp3'),
    Audio('mp3/134.mp3'),
    Audio('mp3/135.mp3'),
    Audio('mp3/136.mp3'),
    Audio('mp3/137.mp3'),
    Audio('mp3/138.mp3'),
    Audio('mp3/139.mp3'),
    Audio('mp3/140.mp3'),
    Audio('mp3/141.mp3'),
    Audio('mp3/142.mp3'),
    Audio('mp3/143.mp3'),
    Audio('mp3/144.mp3'),
    Audio('mp3/145.mp3'),
    Audio('mp3/146.mp3'),
    Audio('mp3/147.mp3'),
    Audio('mp3/148.mp3'),
    Audio('mp3/149.mp3'),
    Audio('mp3/150.mp3'),
    Audio('mp3/151.mp3'),
    Audio('mp3/152.mp3'),
    Audio('mp3/153.mp3'),
    Audio('mp3/154.mp3'),
    Audio('mp3/155.mp3'),
    Audio('mp3/156.mp3'),
    Audio('mp3/157.mp3'),
    Audio('mp3/158.mp3'),
    Audio('mp3/159.mp3'),
    Audio('mp3/160.mp3'),
    Audio('mp3/161.mp3'),
    Audio('mp3/162.mp3'),
    Audio('mp3/163.mp3'),
    Audio('mp3/164.mp3'),
    Audio('mp3/165.mp3'),
    Audio('mp3/166.mp3'),
    Audio('mp3/167.mp3'),
    Audio('mp3/168.mp3'),
    Audio('mp3/169.mp3'),
    Audio('mp3/170.mp3'),
    Audio('mp3/171.mp3'),
    Audio('mp3/172.mp3'),
    Audio('mp3/173.mp3'),
    Audio('mp3/174.mp3'),
    Audio('mp3/175.mp3'),
    Audio('mp3/176.mp3'),
    Audio('mp3/177.mp3'),
    Audio('mp3/178.mp3'),
    Audio('mp3/179.mp3'),
    Audio('mp3/180.mp3'),
    Audio('mp3/181.mp3'),
    Audio('mp3/182.mp3'),
    Audio('mp3/183.mp3'),
    Audio('mp3/184.mp3'),
    Audio('mp3/185.mp3'),
    Audio('mp3/186.mp3'),
    Audio('mp3/187.mp3'),
    Audio('mp3/188.mp3'),
    Audio('mp3/189.mp3'),
    Audio('mp3/190.mp3'),
    Audio('mp3/191.mp3'),
    Audio('mp3/192.mp3'),
    Audio('mp3/193.mp3'),
    Audio('mp3/194.mp3'),
    Audio('mp3/195.mp3'),
    Audio('mp3/196.mp3'),
    Audio('mp3/197.mp3'),
    Audio('mp3/198.mp3'),
    Audio('mp3/199.mp3'),
    Audio('mp3/200.mp3'),
    Audio('mp3/201.mp3'),
    Audio('mp3/202.mp3'),
    Audio('mp3/203.mp3'),
    Audio('mp3/204.mp3'),
    Audio('mp3/205.mp3'),
    Audio('mp3/206.mp3'),
    Audio('mp3/207.mp3'),
    Audio('mp3/208.mp3'),
    Audio('mp3/209.mp3'),
    Audio('mp3/210.mp3'),
    Audio('mp3/211.mp3'),
    Audio('mp3/212.mp3'),
    Audio('mp3/213.mp3'),
    Audio('mp3/214.mp3'),
    Audio('mp3/215.mp3'),
    Audio('mp3/216.mp3'),
    Audio('mp3/217.mp3'),
    Audio('mp3/218.mp3'),
    Audio('mp3/219.mp3'),
    Audio('mp3/220.mp3'),
    Audio('mp3/221.mp3'),
    Audio('mp3/222.mp3'),
    Audio('mp3/223.mp3'),
    Audio('mp3/224.mp3'),
    Audio('mp3/225.mp3'),
    Audio('mp3/226.mp3'),
    Audio('mp3/227.mp3'),
    Audio('mp3/228.mp3'),
    Audio('mp3/229.mp3'),
    Audio('mp3/230.mp3'),
    Audio('mp3/231.mp3'),
    Audio('mp3/232.mp3'),
    Audio('mp3/233.mp3'),
    Audio('mp3/234.mp3'),
    Audio('mp3/235.mp3'),
    Audio('mp3/236.mp3'),
    Audio('mp3/237.mp3'),
    Audio('mp3/238.mp3'),
    Audio('mp3/239.mp3'),
    Audio('mp3/240.mp3'),
    Audio('mp3/241.mp3'),
    Audio('mp3/242.mp3'),
    Audio('mp3/243.mp3'),
    Audio('mp3/244.mp3'),
    Audio('mp3/245.mp3'),
    Audio('mp3/246.mp3'),
    Audio('mp3/247.mp3'),
    Audio('mp3/248.mp3'),
    Audio('mp3/249.mp3'),
    Audio('mp3/250.mp3'),
    Audio('mp3/251.mp3'),
    Audio('mp3/252.mp3'),
    Audio('mp3/253.mp3'),
    Audio('mp3/254.mp3'),
    Audio('mp3/255.mp3'),
    Audio('mp3/256.mp3'),
    Audio('mp3/257.mp3'),
    Audio('mp3/258.mp3'),
    Audio('mp3/259.mp3'),
    Audio('mp3/260.mp3'),
    Audio('mp3/261.mp3'),
    Audio('mp3/262.mp3'),
    Audio('mp3/263.mp3'),
    Audio('mp3/264.mp3'),
    Audio('mp3/265.mp3'),
    Audio('mp3/266.mp3'),
    Audio('mp3/267.mp3'),
    Audio('mp3/268.mp3'),
    Audio('mp3/269.mp3'),
    Audio('mp3/270.mp3'),
    Audio('mp3/271.mp3'),
    Audio('mp3/272.mp3'),
    Audio('mp3/273.mp3'),
    Audio('mp3/274.mp3'),
    Audio('mp3/275.mp3'),
    Audio('mp3/276.mp3'),
    Audio('mp3/277.mp3'),
    Audio('mp3/278.mp3'),
    Audio('mp3/279.mp3'),
    Audio('mp3/280.mp3'),
    Audio('mp3/281.mp3'),
    Audio('mp3/282.mp3'),
    Audio('mp3/283.mp3'),
    Audio('mp3/284.mp3'),
    Audio('mp3/285.mp3'),
    Audio('mp3/286.mp3'),
    Audio('mp3/287.mp3'),
    Audio('mp3/288.mp3'),
  ];

  // init state listeyi başta çağırır resimleri bu şekilde çağırmak şart için bu şekilde listelemek gerekiyor

  @override
  void initState() {
    super.initState();

    // ses dosyalarına ait kodlar
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));
    openPlayer();

    _pageNumbers = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20",
      "21",
      "22",
      "23",
      "24",
      "25",
      "26",
      "27",
      "28",
      "29",
      "30",
      "31",
      "32",
      "33",
      "34",
      "35",
      "36",
      "37",
      "38",
      "39",
      "40",
      "41",
      "42",
      "43",
      "44",
      "45",
      "46",
      "47",
      "48",
      "49",
      "50",
      "51",
      "52",
      "53",
      "54",
      "55",
      "56",
      "57",
      "58",
      "59",
      "60",
      "61",
      "62",
      "63",
      "64",
      "65",
      "66",
      "67",
      "68",
      "69",
      "70",
      "71",
      "72",
      "73",
      "74",
      "75",
      "76",
      "77",
      "78",
      "79",
      "80",
      "81",
      "82",
      "83",
      "84",
      "85",
      "86",
      "87",
      "88",
      "89",
      "90",
      "91",
      "92",
      "93",
      "94",
      "95",
      "96",
      "97",
      "98",
      "99",
      "100",
      "101",
      "102",
      "103",
      "104",
      "105",
      "106",
      "107",
      "108",
      "109",
      "110",
      "111",
      "112",
      "113",
      "114",
      "115",
      "116",
      "117",
      "118",
      "119",
      "120",
      "121",
      "122",
      "123",
      "124",
      "125",
      "126",
      "127",
      "128",
      "129",
      "130",
      "131",
      "132",
      "133",
      "134",
      "135",
      "136",
      "137",
      "138",
      "139",
      "140",
      "141",
      "142",
      "143",
      "144",
      "145",
      "146",
      "147",
      "148",
      "149",
      "150",
      "151",
      "152",
      "153",
      "154",
      "155",
      "156",
      "157",
      "158",
      "159",
      "160",
      "161",
      "162",
      "163",
      "164",
      "165",
      "166",
      "167",
      "168",
      "169",
      "170",
      "171",
      "172",
      "173",
      "174",
      "175",
      "176",
      "177",
      "178",
      "179",
      "180",
      "181",
      "182",
      "183",
      "184",
      "185",
      "186",
      "187",
      "188",
      "189",
      "190",
      "191",
      "192",
      "193",
      "194",
      "195",
      "196",
      "197",
      "198",
      "199",
      "200",
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
      "215",
      "216",
      "217",
      "218",
      "219",
      "220",
      "221",
      "222",
      "223",
      "224",
      "225",
      "226",
      "227",
      "228",
      "229",
      "230",
      "231",
      "232",
      "233",
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
      "250",
      "251",
      "252",
      "253",
      "254",
      "255",
      "256",
      "257",
      "258",
      "259",
      "260",
      "261",
      "262",
      "263",
      "264",
      "265",
      "266",
      "267",
      "268",
      "269",
      "270",
      "271",
      "272",
      "273",
      "274",
      "275",
      "276",
      "277",
      "278",
      "279",
      "280",
      "281",
      "282",
      "283",
      "284",
      "285",
      "286",
      "287",
      "288",
    ];
    _pageNumbers.first;
    _pageImages = [
      "1.jpg",
      "2.jpg",
      "3.jpg",
      "4.jpg",
      "5.jpg",
      "6.jpg",
      "7.jpg",
      "8.jpg",
      "9.jpg",
      "10.jpg",
      "11.jpg",
      "12.jpg",
      "13.jpg",
      "14.jpg",
      "15.jpg",
      "16.jpg",
      "17.jpg",
      "18.jpg",
      "19.jpg",
      "20.jpg",
      "21.jpg",
      "22.jpg",
      "23.jpg",
      "24.jpg",
      "25.jpg",
      "26.jpg",
      "27.jpg",
      "28.jpg",
      "29.jpg",
      "30.jpg",
      "31.jpg",
      "32.jpg",
      "33.jpg",
      "34.jpg",
      "35.jpg",
      "36.jpg",
      "37.jpg",
      "38.jpg",
      "39.jpg",
      "40.jpg",
      "41.jpg",
      "42.jpg",
      "43.jpg",
      "44.jpg",
      "45.jpg",
      "46.jpg",
      "47.jpg",
      "48.jpg",
      "49.jpg",
      "50.jpg",
      "51.jpg",
      "52.jpg",
      "53.jpg",
      "54.jpg",
      "55.jpg",
      "56.jpg",
      "57.jpg",
      "58.jpg",
      "59.jpg",
      "60.jpg",
      "61.jpg",
      "62.jpg",
      "63.jpg",
      "64.jpg",
      "65.jpg",
      "66.jpg",
      "67.jpg",
      "68.jpg",
      "69.jpg",
      "70.jpg",
      "71.jpg",
      "72.jpg",
      "73.jpg",
      "74.jpg",
      "75.jpg",
      "76.jpg",
      "77.jpg",
      "78.jpg",
      "79.jpg",
      "80.jpg",
      "81.jpg",
      "82.jpg",
      "83.jpg",
      "84.jpg",
      "85.jpg",
      "86.jpg",
      "87.jpg",
      "88.jpg",
      "89.jpg",
      "90.jpg",
      "91.jpg",
      "92.jpg",
      "93.jpg",
      "94.jpg",
      "95.jpg",
      "96.jpg",
      "97.jpg",
      "98.jpg",
      "99.jpg",
      "100.jpg",
      "101.jpg",
      "102.jpg",
      "103.jpg",
      "104.jpg",
      "105.jpg",
      "106.jpg",
      "107.jpg",
      "108.jpg",
      "109.jpg",
      "110.jpg",
      "111.jpg",
      "112.jpg",
      "113.jpg",
      "114.jpg",
      "115.jpg",
      "116.jpg",
      "117.jpg",
      "118.jpg",
      "119.jpg",
      "120.jpg",
      "121.jpg",
      "122.jpg",
      "123.jpg",
      "124.jpg",
      "125.jpg",
      "126.jpg",
      "127.jpg",
      "128.jpg",
      "129.jpg",
      "130.jpg",
      "131.jpg",
      "132.jpg",
      "133.jpg",
      "134.jpg",
      "135.jpg",
      "136.jpg",
      "137.jpg",
      "138.jpg",
      "139.jpg",
      "140.jpg",
      "141.jpg",
      "142.jpg",
      "143.jpg",
      "144.jpg",
      "145.jpg",
      "146.jpg",
      "147.jpg",
      "148.jpg",
      "149.jpg",
      "150.jpg",
      "151.jpg",
      "152.jpg",
      "153.jpg",
      "154.jpg",
      "155.jpg",
      "156.jpg",
      "157.jpg",
      "158.jpg",
      "159.jpg",
      "160.jpg",
      "161.jpg",
      "162.jpg",
      "163.jpg",
      "164.jpg",
      "165.jpg",
      "166.jpg",
      "167.jpg",
      "168.jpg",
      "169.jpg",
      "170.jpg",
      "171.jpg",
      "172.jpg",
      "173.jpg",
      "174.jpg",
      "175.jpg",
      "176.jpg",
      "177.jpg",
      "178.jpg",
      "179.jpg",
      "180.jpg",
      "181.jpg",
      "182.jpg",
      "183.jpg",
      "184.jpg",
      "185.jpg",
      "186.jpg",
      "187.jpg",
      "188.jpg",
      "189.jpg",
      "190.jpg",
      "191.jpg",
      "192.jpg",
      "193.jpg",
      "194.jpg",
      "195.jpg",
      "196.jpg",
      "197.jpg",
      "198.jpg",
      "199.jpg",
      "200.jpg",
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
      "215.jpg",
      "216.jpg",
      "217.jpg",
      "218.jpg",
      "219.jpg",
      "220.jpg",
      "221.jpg",
      "222.jpg",
      "223.jpg",
      "224.jpg",
      "225.jpg",
      "226.jpg",
      "227.jpg",
      "228.jpg",
      "229.jpg",
      "230.jpg",
      "231.jpg",
      "232.jpg",
      "233.jpg",
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
      "250.jpg",
      "251.jpg",
      "252.jpg",
      "253.jpg",
      "254.jpg",
      "255.jpg",
      "256.jpg",
      "257.jpg",
      "258.jpg",
      "259.jpg",
      "260.jpg",
      "261.jpg",
      "262.jpg",
      "263.jpg",
      "264.jpg",
      "265.jpg",
      "266.jpg",
      "267.jpg",
      "268.jpg",
      "269.jpg",
      "270.jpg",
      "271.jpg",
      "272.jpg",
      "273.jpg",
      "274.jpg",
      "275.jpg",
      "276.jpg",
      "277.jpg",
      "278.jpg",
      "279.jpg",
      "280.jpg",
      "281.jpg",
      "282.jpg",
      "283.jpg",
      "284.jpg",
      "285.jpg",
      "286.jpg",
      "287.jpg",
      "288.jpg",
    ];
    _pageImages.reversed.toList();
  }

  // Geri döndüğünde sesi kapatır // dispose

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

  // Ses dosyasını açmak için

  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId('music');

  final List<StreamSubscription> _subscriptions = [];
  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  // Kaydırma efectinin kodları

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

  // Geri dönme buttonu

  Widget _arrowBackPage() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.arrow_back_ios, size: 30),
      ),
    );
  }

  // Açılan ShowDialog kodları buradan başlıyor

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

  // Filtreleme kodları buradan başlar

  String _query = "";

  TextEditingController _searchview = TextEditingController();

  _CumartesiState() {
    _searchview.addListener(
      () {
        if (_searchview.text.isEmpty) {
          setState(() {
            _firstSearch = true;
            _query = "";
          });
        } else {
          setState(() {
            _firstSearch = false;
            _query = _searchview.text;
          });
        }
      },
    );
  }

  Widget _performSearch() {
    _filterPageNumber = List<String>();
    for (int i = 0; i < _pageNumbers.length; i++) {
      var item = _pageNumbers[i];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterPageNumber.add(item);
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        itemCount: _filterPageNumber.length,
        itemBuilder: (context, index) {
          final item = audios[int.parse(_filterPageNumber[index]) - 1];
          return Column(
            children: [
              Expanded(
                flex: 8,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await _assetsAudioPlayer.open(
                        item,
                        autoStart: true,
                        showNotification: true,
                        playInBackground: PlayInBackground.enabled,
                        audioFocusStrategy: AudioFocusStrategy.request(
                            resumeAfterInterruption: true,
                            resumeOthersPlayersAfterDone: true),
                        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                        notificationSettings: NotificationSettings(),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    child: PhotoView.customChild(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                            "assets/${_filterPageNumber[index]}.jpg"),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PlayerBuilder.isPlaying(
                  player: _assetsAudioPlayer,
                  builder: (context, isPlaying) {
                    return PlayingControls(
                      pageNumber: "${_filterPageNumber[index]}",
                      isPlaying: isPlaying,
                      isPlaylist: true,
                      onPlay: () {
                        _assetsAudioPlayer.playOrPause();
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
