import 'dart:async';
import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:audio_session/audio_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mafatih/audio/common.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/home2.dart';
import 'package:mafatih/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/data/models/DailyDoa4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:mafatih/ui/detailSec44.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:screen/screen.dart';
import '../constants.dart';



class DetailSec5 extends StatefulWidget {
  final detail, index, indent, indexFasl, code, query;
  DetailSec5({
    Key key,
    @required this.detail,
    this.index,
    this.indent,
    this.indexFasl,
    this.code,
    this.query,
  }) : super(key: key);

  @override
  _DetailSec5State createState() => _DetailSec5State();
}

class _DetailSec5State extends State<DetailSec5> {
  int _selectedIndex = 0;
  SharedPreferences prefs;
  bool isBookmarked;
  static Color iconBookmarkcolor;
  String titleCurrentPage;
  int indexCurrentPage;
  int indexFaslCurrentPage;
  int codeCurrentPage;
  ScrollController _controller;
  final itemSize = globals.fontTozihLevel * 1.7;
  final queryOffset = 100;

  var client = http.Client();
  bool isPlaying = false;
  num curIndex = 0;
  AudioPlayer _player;

  @override
  void dispose() {
    _player.stop();     _player.setLoopMode(LoopMode.off);
    _player.dispose();
    print("************************************************************************dispos detailsec");
    _scrollController.dispose();
    super.dispose();
  }


  _onItemTapped(int indexTab) {
    setState(() {
      _selectedIndex = indexTab;
      if (indexTab == 2) {
        isBookmarked
            ? setState(() {
          iconBookmarkcolor = Colors.white;
          globals.titleBookMarked.remove(globals.titleCurrentPage);
          globals.indexBookMarked.remove(globals.indexCurrentPage);
          globals.indexFaslBookMarked
              .remove(globals.indexFaslCurrentPage);
          globals.codeBookMarked.remove(globals.codeCurrentPage);
          isBookmarked = false;
          print(
              "toRemove %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
        })
            : setState(() {
          iconBookmarkcolor = Colors.red;
          globals.titleBookMarked.add(globals.titleCurrentPage);
          globals.indexBookMarked.add(globals.indexCurrentPage);
          globals.indexFaslBookMarked.add(globals.indexFaslCurrentPage);
          globals.codeBookMarked.add(globals.codeCurrentPage);
          isBookmarked = true;

          print(
              "toSave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
        });
        if (globals.indexBookMarked != null) {
          setBookmark(globals.titleBookMarked, globals.indexBookMarked,
              globals.indexFaslBookMarked, globals.codeBookMarked);
        }
      } else if (indexTab == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else if (indexTab == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Settings()));
      }
    });
  }

  PageController _pageControllerBuilder() {
    return new PageController(
        initialPage: widget.detail, viewportFraction: 1.1, keepPage: true);
  }
  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }
    return input;
  }

  /// set bookmarkPage in sharedPreferences
  void setBookmark(List<String> _title, List<int> _index, List<int> _indexFasl,
      List<int> _code) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_title, _title);

    List<String> _strindex = _index.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_index, _strindex);

    List<String> _strindexFasl = _indexFasl.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_indexFasl, _strindexFasl);

    List<String> _strcode = _code.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_Code, _strcode);
  }

  void setLastViewedPage(String _titleCurrentPage, int _indexCurrentPage,
      int _indexFaslCurrentPage) async {
    prefs = await SharedPreferences.getInstance();
    if (_indexCurrentPage != null && !_indexCurrentPage.isNaN) {
      prefs.setString(globals.LAST_VIEWED_PAGE_title, _titleCurrentPage);
      globals.titlelastViewedPage =
          prefs.getString(globals.LAST_VIEWED_PAGE_title);

      prefs.setInt(globals.LAST_VIEWED_PAGE_index, _indexCurrentPage);
      globals.indexlastViewedPage =
          prefs.getInt(globals.LAST_VIEWED_PAGE_index);

      prefs.setInt(globals.LAST_VIEWED_PAGE_indexFasl, _indexFaslCurrentPage);
      globals.indexFasllastViewedPage =
          prefs.getInt(globals.LAST_VIEWED_PAGE_indexFasl);
    }
  }

  closePage(page) async {
    await page.close();
  }

  PageController pageController;
  double _scrollPosition;
  ScrollController _scrollController;
  setLastScolledPixel(double level) async {
    globals.lastScrolledPixel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.LAST_SCROLLED_PIXEL, level);
    print('globals.lastScrolledPixel');
    print(globals.lastScrolledPixel);
  }
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      setLastScolledPixel(_scrollPosition);
    });
  }
  getLastScolledPixel() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.LAST_SCROLLED_PIXEL)) {
      double _lastScrolledPixel = prefs.getDouble(globals.LAST_SCROLLED_PIXEL);
      setState(() {
        globals.lastScrolledPixel = _lastScrolledPixel;
      });
    }
  }

  @override
  void initState() {
    print("********************************************** widget.code  5**************************** ${widget.code} ");
    final url = globals.audioUrl+"${widget.indexFasl*1000+widget.index}.mp3";
    if (globals.jsonCodesHavingAudio.contains(widget.code)) {
      print("************************************************************************** jsonCodesHavingAudio.contains(widget.code) ");
      globals.audioExist=true;
    } else {
      globals.audioExist=false;
    }



    _player = AudioPlayer();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _init(widget.code);


    print(
        "************************************************************************** widget.indexFasl " +
            widget.indexFasl.toString());
    print(
        "************************************************************************** widget.indexFasl " +
            widget.index.toString());

    setState(() {
      if (globals.codeBookMarked.contains(widget.code)) {
        print(
            "       <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  globals.titleBookMarked.contains(${widget.detail})");
        isBookmarked = true;
        iconBookmarkcolor = Colors.red;
      } else {
        print(
            "       <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  globals.titleBookMarked does NOT contain (${widget.detail})");
        isBookmarked = false;
        iconBookmarkcolor = Colors.white;
      }
    });
    setLastViewedPage(widget.detail, widget.index, widget.indexFasl);
    if (globals.titleBookMarked == null) {
      isBookmarked = false;
      print("globals.titleBookMarked== null ????????????????????????????");
      globals.titleBookMarked = [];
      globals.indexBookMarked = [];
      globals.indexFaslBookMarked = [];
    }

    Screen.keepOn(true);
    super.initState();
  }

  List<TextSpan> highlightOccurrencesDetailSec(
      String source, String query, double _fontSize) {
    if (query == null ||
        query.isEmpty ||
        !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());
    int lastMatchEnd = 0;
    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);
      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _fontSize,
            color: Colors.green
        ),
      ));
      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }
      lastMatchEnd = match.end;
    }
    return children;
  }
  void _scrollToPixel() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(globals.lastScrolledPixel,
          duration: Duration(milliseconds: 100), curve: Curves.fastOutSlowIn);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToPixel());
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));


  Future<void> _init(jsonCode) async {
    print("////////////////////////////////////.........................// _init   ${globals.audioExist}");
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });

    try {
      print("////////////////////////////////////.........................// setAudioSource   ${globals.audioExist}");
      await _player.setLoopMode(LoopMode.off);        // Set playlist to loop (off|all|one)
      final duration = await _player.setFilePath('${globals.cacheAudio}/${widget.code}.mp3');
    } catch (e, stackTrace) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      print(stackTrace);
    }
  }

  double progress = null;
  String status = "Not Downloaded";
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }


  void _downloadButtonPressed() async {
    bool isOnline = await hasNetwork();

    if(isOnline==true) {
      setState(() {
        progress = null;
      });
      String audioUrl = 'https://www.videoir.com/apps_versions/audios/${widget
          .code}.mp3';
      final request = Request('GET', Uri.parse(audioUrl));
      final StreamedResponse response = await Client().send(request);
      final contentLength = response.contentLength;
      setState(() {
        progress = 0.000001;
        status = "دانلود شروع شد";
      });
      Fluttertoast.showToast(
          msg: "دانلود شروع شد",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);
      List<int> bytes = [];
      final file = await _getFile('${widget.code}.mp3');
      response.stream.listen(
            (List<int> newBytes) {
          // update progress
          bytes.addAll(newBytes);
          final downloadedLength = bytes.length;
          setState(() {
            progress = downloadedLength.toDouble() / (contentLength ?? 1);
            status = "   در حال دانلود ${((progress ?? 0) * 100).toStringAsFixed(2)} % ";
          });
          print("progress: $progress");
        },
        onDone: () async {
          // save file
          setState(() {
            progress = 1;
            status = "دانلود تکمیل شد";
          });
          Fluttertoast.showToast(
              msg: "دانلود تکمیل شد",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          await file.writeAsBytes(bytes);
          final duration = await _player.setFilePath(
              '${globals.cacheAudio}/${widget.code}.mp3');

          debugPrint("Download finished");
        },
        onError: (e) {
          print(
              "/////////////////////////////////////////////////////////////////////////////// error $e");
          Fluttertoast.showToast(
              msg: "لطفا از اتصال دستگاه خود به اینترنت مطمئن شوید.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);

          debugPrint(e);
        },
        cancelOnError: true,
      );

    }else if (isOnline==false){      Fluttertoast.showToast(
        msg: "برای دانلود فایل صوتی لطفا به اینترنت متصل شوید",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);}

  }

  Future<File> _getFile(String filename) async {
    final dir = await getTemporaryDirectory();
    // final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$filename");
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('https://www.google.com/');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;

      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "برای دانلود فایل صوتی لطفا به اینترنت متصل شوید",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);

      return false;

    }
  }


  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);
    ui.edameFarazSet==true?WidgetsBinding.instance.addPostFrameCallback((_) {_scrollToPixel();ui.edameFarazSet=false;} ):null;
    bool audioIsSaved=File("data/user/0/pydart.mafatih/cache/${widget.code}.mp3").existsSync();


    return
      Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.bookmark,
              color: iconBookmarkcolor,
            ),
            onPressed: () {
              String smsSaved = "با موفقیت به منتخب ها افزوده شد";
              String smsRemoved = "با موفقیت از منتخب ها حذف شد";
              Fluttertoast.showToast(
                  msg: isBookmarked ? smsRemoved : smsSaved,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 18.0);
              _onItemTapped(2);
            },
          ),
          bottom:
          globals.jsonCodesHavingAudio.contains((1000 *widget.indexFasl + widget.index).toString()) ?
// globals.audioExist?
          PreferredSize(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  if ((progress==null && audioIsSaved!=true)|| (progress==0 && audioIsSaved!=null) ) IconButton(
                    icon:  Image.asset("assets/play.png"),
                    iconSize: 50.0,
                    onPressed:
                    progress==null ? ((_downloadButtonPressed)) : null,

                  ),
                  if ((progress==null && audioIsSaved!=true)|| (progress==0 && audioIsSaved!=null) ) Text(
                    "دانلود فایل صوتی",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IRANSans',
                        fontSize: 10,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.right,
                  ),
                  if (progress!=null && progress!=0 && progress<1) CircularProgressIndicator(
                    value: progress,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.green,
                    backgroundColor: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  if (progress!=null && progress!=0 && progress<1) SizedBox(height: 20,),
                  if (progress!=null && progress!=0 && progress<1) Text(
                    status,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IRANSans',
                        fontSize: 12,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 10,),
                  if (audioIsSaved==true || (progress!=null && progress==1))ControlButtons(_player),
                  if (audioIsSaved==true || (progress!=null && progress==1))StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        duration: positionData?.duration ?? Duration.zero,
                        position: positionData?.position ?? Duration.zero,
                        bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                        onChangeEnd: (newPosition) {
                          _player.seek(newPosition);
                        },
                      );
                    },
                  ),
                ]),
            preferredSize: Size(0.0, 80.0),
          ):null,
          title: Center(
              child: Text(
                widget.detail,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.titleupdetailsec,
                maxLines: 2,
              )),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()))),
          ],
        ),
        body: (ui.terjemahan == false)
            ? FutureBuilder<DailyDoa4>(
          future: ServiceData().loadSec4(widget.indexFasl, globals.tarjKhati==true && globals.khatiedDoa.contains(1000 *widget.indexFasl + widget.index) ? (1000 *widget.indexFasl + widget.index).toString() : widget.index.toString() ),
          builder: (c, snapshot) {
            if (snapshot.hasData) {
              titleCurrentPage = snapshot.data.title;
              globals.titleCurrentPage = titleCurrentPage;
              indexCurrentPage = snapshot.data.number;
              globals.indexCurrentPage = indexCurrentPage;
              indexFaslCurrentPage = snapshot.data.bab;
              globals.indexFaslCurrentPage = indexFaslCurrentPage;
              codeCurrentPage =
                  indexFaslCurrentPage * 1000 + indexCurrentPage;
              globals.codeCurrentPage = codeCurrentPage;
              print(
                  "titleCurrentPage      <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   " +
                      titleCurrentPage);
            }

            return snapshot.hasData
                ? Column(children: <Widget>[
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: _scrollController,
//                        itemExtent: 1000,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data.arabic.length,
                    itemBuilder: (BuildContext c, int i) {
                      String key =
                      snapshot.data.arabic.keys.elementAt(i);
                      return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0),
                              child: Column(
                                children: <Widget>[
                                  if (int.parse(key) -
                                      snapshot.data.delay ==
                                      1)
                                    ListTile(
                                      dense: true,
                                      title: Text(
                                        'بِسْمِ اللَّـهِ الرَّ حْمَـٰنِ الرَّ حِيمِ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppStyle
                                              .textQuranfontFamily,
                                          fontSize: 1.2 *
                                              globals.fontArabicLevel,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  if (snapshot.data.arabic[key] !=
                                      "" &&
                                      snapshot.data.arabic[key] !=
                                          null &&
                                      widget.indexFasl >= 4)
                                    ListTile(
                                      dense: true,
                                      title: RichText(
                                        textAlign: TextAlign.right,
                                        text: TextSpan(
                                          text: replaceFarsiNumber(
                                              (snapshot.data
                                                  .arabic[key])
                                                  .toString()),
                                          style: TextStyle(
                                            fontFamily: AppStyle
                                                .textQuranfontFamily,
                                            fontSize: 1.2 *
                                                globals
                                                    .fontArabicLevel,
                                            height: 1.5,
                                            color: Theme.of(context)
                                                .accentColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ]);
                    },
                  ),
                ),
              )
            ])
                : Center(child: CircularProgressIndicator());
          },
        )
            : DetailSec44(
          detail: widget.detail,
          index: widget.index,
          indent: widget.indent,
          indexFasl: 4,
          code: widget.indexFasl * 1000 + widget.index,
          player: _player,
        ),
        bottomNavigationBar: AdmobBanner(
          adUnitId: 'ca-app-pub-5524959616213219/7557264464',
          adSize: AdmobBannerSize.BANNER,
          // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          //   if (event == AdmobAdEvent.clicked) {}
          // },
        ),
      );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player, {Key key}) : super(key: key);
  final audioUrl = "https://www.videoir.com/apps_versions/audios/ashoura/1110.mp3";
  Future<void> _init(jsonCode) async {
    print("////////////////////////////////////.........................// _init Playing controls ");
    try {
      print("////////////////////////////////////.........................// setAudioSource   ${Constants.audiosListUrl}$jsonCode.mp3'");
      await player.setLoopMode(LoopMode.off);        // Set playlist to loop (off|all|one)
      final audioSource = LockCachingAudioSource(Uri.parse('${Constants.audiosListUrl}/$jsonCode.mp3'));
      await player.setAudioSource(audioSource);
    } catch (e, stackTrace) {
      print("Error loading playlist: $e");
      print(stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {

    return
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<double>(
            stream: player.speedStream,
            builder: (context, snapshot) => IconButton(
              icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                showSliderDialog(
                  context: context,
                  title: "تنظیم سرعت",
                  divisions: 20,
                  min: 0.1,
                  max: 1.9,
                  stream: player.speedStream,
                  onChanged: player.setSpeed, value: player.speed,
                );
              },
            ),
          ),
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;

              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  margin: const EdgeInsets.all(0.0),
                  width: 30.0,
                  height: 30.0,
                  child: const CircularProgressIndicator(),
                );
              }
              else if (playing != true  ) {
                return IconButton(
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 30.0,
                  onPressed:
                  player.play,
                );
              }

              else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(Icons.pause),
                  iconSize: 30.0,
                  onPressed: player.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.replay),
                  iconSize: 30.0,
                  onPressed: () => player.seek(Duration.zero,
                      index: player.effectiveIndices.first),
                );
              }
            },
          ),
          // PopupMenuButton<String>(
          //   icon: Icon(Icons.playlist_play_outlined),
          //
          //   onSelected: (value) {
          //     // int intIndexofValue=soundList.indexOf(value);
          //     tempsound = value;
          //     print('///////////////////////////              /////////////////   $tempsound');
          //     print('///////////////////////////              /////////////////value   $value');
          //
          //     ui.soundFormat = tempsound;
          //     setSound(tempsound);
          //     player?.stop();
          //     _init(_jsonCode);
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //     haveAudio[_jsonCode].length>0? PopupMenuItem<String>(
          //       value: '0',
          //       child: Text(haveAudio[_jsonCode][0]),
          //       textStyle:TextStyle(
          //         color: tempsound == '0'
          //             ? Colors.red
          //             : Theme.of(context).accentColor,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ):null,
          //     haveAudio[_jsonCode].length>1?PopupMenuItem<String>(
          //       value: '1',
          //       child: Text(haveAudio[_jsonCode][1]),
          //       textStyle:TextStyle(
          //         color: tempsound == '1'
          //             ? Colors.red
          //             : Theme.of(context).accentColor,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ):null,
          //     haveAudio[_jsonCode].length>2?PopupMenuItem<String>(
          //       value: '2',
          //       child: Text(haveAudio[_jsonCode][2]),
          //       textStyle:TextStyle(
          //         color: tempsound == '2'
          //             ? Colors.red
          //             : Theme.of(context).accentColor,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ):null,
          //     haveAudio[_jsonCode].length>3?PopupMenuItem<String>(
          //   value: '3',
          //   child: Text(haveAudio[_jsonCode][3]),
          //   textStyle:TextStyle(
          //     color: tempsound == '3'
          //         ? Colors.red
          //         : Theme.of(context).accentColor,
          //     fontWeight: FontWeight.bold,
          //    ),
          //  ):null,
          //   ],
          // ),
        ],
      );
  }
}
