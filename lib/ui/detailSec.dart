import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:audio_session/audio_session.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_screen/flutter_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:mafatih/audio/common.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/library/Globals.dart';
import 'package:mafatih/ui/home2.dart';
import 'package:mafatih/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/data/models/DailyDoa.dart';
// import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../constants.dart';
import 'notesSearch.dart';

class DetailSec extends StatefulWidget {
  final detail, index, indent, indexFasl, code, query;
  DetailSec({
    Key key,
    @required this.detail,
    this.index,
    this.indent,
    this.indexFasl,
    this.code,
    this.query,
  }) : super(key: key);

  @override
  _DetailSecState createState() => _DetailSecState();
}

class _DetailSecState extends State<DetailSec> {
  /// Used for Bottom Navigation
  int _selectedIndex = 0;
//  Home indexTabHomeDetailSec = Home();
//  indexTabHomeDetailSec.indexTabHome=0;
  /// Declare SharedPreferences
  SharedPreferences prefs;
  bool isBookmarked;
  static Color iconBookmarkcolor;

  Widget _bookmarkWidget = Container();

  String titleCurrentPage;
  int indexCurrentPage;
  int indexFaslCurrentPage;
  int codeCurrentPage;
  // var themeNotifier = ThemeNotifier();

  ScrollController _controller;
  final itemSize = globals.fontTozihLevel * 1.7;
  final queryOffset = 100;

  var client = http.Client();
  // String filePath = "assets/sounds/${globals.sound}.mp3";
  bool isPlaying = false;
  num curIndex = 0;
  AudioPlayer _player;
  // String tempsound = globals.sound;

  // _moveUp() {
  //   //_controller.jumpTo(_controller.offset - itemSize);
  //   _controller.animateTo(_scrollPosition - 100,
  //       curve: Curves.linear, duration: Duration(milliseconds: 500));
  // }
  //
  // _moveDown() {
  //   //_controller.jumpTo(_controller.offset + itemSize);
  //   _controller.animateTo(_scrollPosition,
  //       curve: Curves.linear, duration: Duration(milliseconds: 500));
  // }





  @override
  void dispose() {
    _player.stop();     _player.setLoopMode(LoopMode.off);
    _player.dispose();
    print("************************************************************************dispos detailsec");
    _scrollController.dispose();
    super.dispose();
  }

  getOtherSettings() async {
    SharedPreferences prefs;

    prefs = await SharedPreferences.getInstance();
    setState(() {
      globals.titlelastViewedPage =
          prefs.getString(globals.LAST_VIEWED_PAGE_title);
      globals.indexlastViewedPage =
          prefs.getInt(globals.LAST_VIEWED_PAGE_index);
      globals.indexFasllastViewedPage =
          prefs.getInt(globals.LAST_VIEWED_PAGE_indexFasl);
      globals.indentlastViewedPage =
          prefs.getString(globals.LAST_VIEWED_PAGE_indent);

    });
  }
  /// Navigation event handler
  _onItemTapped(int indexTab) {
    setState(() {
      _selectedIndex = indexTab;

      /// Go to Bookmarked page
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
                    "${globals.codeCurrentPage} -----------------------------------------------globals.codeCurrentPage------------------------------------------------");
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

  /// set bookmarkPage in sharedPreferences
  void setBookmark(List<String> _title, List<int> _index, List<int> _indexFasl,
      List<int> _code) async {
    prefs = await SharedPreferences.getInstance();
//    if (_index[0] != null && !_index[0].isNaN) {
    await prefs.setStringList(globals.BOOKMARKED_PAGE_title, _title);

    List<String> _strindex = _index.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_index, _strindex);

    List<String> _strindexFasl = _indexFasl.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_indexFasl, _strindexFasl);

    List<String> _strcode = _code.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_Code, _strcode);
  }

  /// set lastViewedPage in sharedPreferences
  void setLastViewedPage(String _titleCurrentPage, int _indexCurrentPage,
      int _indexFaslCurrentPage, String _indentCurrentPage) async {
    prefs = await SharedPreferences.getInstance();
    if (_indexCurrentPage != null && !_indexCurrentPage.isNaN) {
      prefs.setString(globals.LAST_VIEWED_PAGE_title, _titleCurrentPage);
      prefs.setInt(globals.LAST_VIEWED_PAGE_index, _indexCurrentPage);
      prefs.setInt(globals.LAST_VIEWED_PAGE_indexFasl, _indexFaslCurrentPage);
      prefs.setString(globals.LAST_VIEWED_PAGE_indent, _indentCurrentPage);


    }
  }

  closePage(page) async {
    await page.close();
  }

  /// Init Page Controller
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
      setLastScolledPixel(_scrollPosition??0);
    });
  }
  // setAudioExist(String jsonCode) async {
  //   (globals.jsonCodesHavingAudio).add(jsonCode);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList('JsonCodesHavingAudio', globals.jsonCodesHavingAudio);
  // }
  // Future<bool> checkUrlExist(String jsonCode) async {
  //   print("**********************************************checkUrlExist**************************** '${Constants.audiosListUrl}/${widget.code}.mp3' ");
  //
  //   final response = await http.get(Uri.parse('${Constants.audiosListUrl}/${widget.code}.mp3'));
  //   print("**********************************************http.get**************************** '${Constants.audiosListUrl}/${widget.code}.mp3' ");
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       print("************************************************************************** response.statusCode == 200 ");
  //
  //       globals.audioExist = true;
  //       return true;
  //     });
  //     setAudioExist(jsonCode.toString());
  //   } else {
  //     setState(() {
  //       globals.audioExist = false;
  //     });
  //     return false;
  //
  //   }
  //   return false;
  //
  // }

  // checkUrlExist(String jsonCode) async {
  //   print("************************************************************************** checkUrlExist   ${Constants.audiosListUrl +'/${widget.code}.txt'}");
  //
  //   try {
  //     http.Response response =
  //     await http.get(Constants.audiosListUrl +'/${widget.code}.txt').whenComplete(() {});
  //     if (response.statusCode == 200) {
  //       var Results = response.body;
  //       print("************************************************************************** response.statusCode == 200 ");
  //       setState(() {
  //         globals.audioExist = true;
  //       });
  //       setAudioExist(jsonCode.toString());
  //
  //     } else {
  //       setState(() {
  //         globals.audioExist = false;
  //       });
  //       print("************************************************************************** Failed to load ");
  //       throw Exception('Failed to load');
  //     }
  //   } catch (e) {
  //     print("Exception Caught: $e");
  //   }
  // }



  @override
  void initState() {
    print("********************************************** widget.code  **************************** ${widget.code} ");
    final url = globals.audioUrl+"${widget.indexFasl*1000+widget.index}.mp3";

    if (globals.jsonCodesHavingAudio.contains(widget.code)) {
      print("************************************************************************** jsonCodesHavingAudio.contains(widget.code) ");
      globals.audioExist=true;
    } else {
      globals.audioExist=false;

      // checkUrlExist(widget.code.toString());
    }



    // _audioFiles();
    _player = AudioPlayer();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _init(widget.code);

    print(
        "************************************************************************** detail sec ");
    // _controller = ScrollController();
    // _controller.addListener(_scrollListener);

    print(
        "************************************************************************** widget.indexFasl " +
            widget.indexFasl.toString());
    print(
        "************************************************************************** widget.index " +
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

    /// Update lastViewedPage
    setLastViewedPage(widget.detail, widget.index, widget.indexFasl, widget.indent);

    if (globals.titleBookMarked == null) {
      isBookmarked = false;
      print("globals.titleBookMarked== null ????????????????????????????");
      globals.titleBookMarked = [];
      globals.indexBookMarked = [];
      globals.indexFaslBookMarked = [];
    }

    /// Prevent screen from going into sleep mode:
    FlutterScreen.keepOn(true);

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
//          style: TextStyle(
//              fontFamily: 'IRANSans', fontSize: 20, color: Colors.grey[900])
        ));
      }
      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _fontSize,
            color: Colors.green
            // color: Colors.black,
            ),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
//        _scrollPosition = _controller.offset;
//        print(
//            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> _scrollPosition $_scrollPosition");
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }
      lastMatchEnd = match.end;
    }
    return children;
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

  void _scrollToPixel() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(globals.lastScrolledPixel,
          duration: Duration(milliseconds: 100), curve: Curves.fastOutSlowIn);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToPixel());
    }

  }

  List<int> khatiedDoa = [
  1110,3153, 1122, 3216, 3224, 1119];

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  // Future<void> _init(jsonCode) async {
  //   print("////////////////////////////////////.........................// _init   ${globals.sound}");
  //   final session = await AudioSession.instance;
  //   await session.configure(const AudioSessionConfiguration.speech());
  //   // Listen to errors during playback.
  //   _player.playbackEventStream.listen((event) {},
  //       onError: (Object e, StackTrace stackTrace) {
  //         print('A stream error occurred: $e');
  //       });
  //   try {
  //     print("////////////////////////////////////.........................// setAudioSource   ${globals.sound}");
  //     await _player.setLoopMode(LoopMode.off);        // Set playlist to loop (off|all|one)
  //     setState(() {
  //       _player.setAudioSource(playlist[jsonCode][(int.parse(globals.sound))], initialPosition: Duration.zero);
  //     });
  //   } catch (e, stackTrace) {
  //     // Catch load errors: 404, invalid url ...
  //     print("Error loading playlist: $e");
  //     print(stackTrace);
  //   }
  // }

  // final audioUrl = "https://www.videoir.com/apps_versions/audios/ashoura/1-fani.mp3";
  // var dio = Dio();

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

      // Good workig well
      // final audioSource = LockCachingAudioSource(Uri.parse('${Constants.audiosListUrl}/$jsonCode.mp3'));
      // await _player.setAudioSource(audioSource);
      ////////////////////////////////////////////////////////////////


      final duration = await _player.setFilePath('${globals.cacheAudio}/${widget.code}.mp3');
      // _player.play();








      // var directory = await getApplicationDocumentsDirectory();
      // String savePath = directory.path + "/1110.mp3";
      // print("///////////////////////////////////////////// ${Uri.parse(globals.cacheAudio)}");




      // await _player.setAudioSource(AudioSource.uri(Uri.parse("file:///${globals.cacheAudio}")));
      // _player.setAudioSource(playlist[0], initialPosition: Duration.zero);

      // await _player.setAudioSource(AudioSource.uri(Uri.f(savePath)));
      // final audioSource = LockCachingAudioSource(Uri.parse('${Constants.audiosListUrl}/$jsonCode.mp3'));
      // await _player.setAudioSource(AudioSource.uri(Uri.parse('https://www.videoir.com/apps_versions/audios/1110.mp3')));
    } catch (e, stackTrace) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      print(stackTrace);
    }
  }



  // void showDownloadProgress(received, total) {
  //   if (total != -1) {
  //     print((received / total * 100).toStringAsFixed(0) + "%");
  //   }
  // }
  // Future download2(Dio dio, String url, String savePath) async {
  //   try {
  //     Response response = await dio.get(
  //       url,
  //       onReceiveProgress: showDownloadProgress,
  //       //Received data with List<int>
  //       options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status < 500;
  //           }),
  //     );
  //     print(response.headers);
  //     File file = File(savePath);
  //     var raf = file.openSync(mode: FileMode.write);
  //     // response.data is List<int> type
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // List file = [];
  // Future _audioFiles() async {
  //   // >> To get paths you need these 2 lines
  //   final manifestContent =
  //   await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
  //
  //   final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  //   // >> To get paths you need these 2 lines
  //   final imagePaths = manifestMap.keys
  //       .where((String key) => key.contains('assets/sounds/'))
  //   // .where((String key) => key.contains('.mp3'))
  //       .toList();
  //
  //   setState(() {
  //     file = imagePaths;
  //   });
  // }

  double progress = null;

  String status = "Not Downloaded";

  /// random download file for demonstration purposes
  /// replace with any file you want to download
  // final url = 'https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_1000MG.mp3';
  // final url = 'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_1920_18MG.mp4';

  void _downloadButtonPressed() async {
    /// when download first called it takes a bit of time to communicate with server.
    /// While that is happening, make circle just spin eternally
    setState(() { progress = null; });
    String audioUrl = 'https://www.videoir.com/apps_versions/audios/${widget.code}.mp3';
    final request = Request('GET', Uri.parse(audioUrl));
    /// calling Client().send() instead of get(url) method.
    /// Reason: send() gives you a stream, and you’re going to listen to the
    /// stream of bytes as it downloads the file from the server
    final StreamedResponse response = await Client().send(request);

    /// response coming from the server contains a header called Content-Length,
    /// which includes the total size of the file in bytes
    final contentLength = response.contentLength;
    // sometimes the server doesn't return this value or sometimes the header gets stripped away.
    // If that’s the case then contentLength will be null.
    // That makes it more difficult to show your users the download progress.
    // There are a couple of options:
    //   - If you have control of the server, you can set the x-decompressed-content-length header
    //     with the file size before you send it. That header seems to stay put.
    //     On the client side you could retrieve the content length like this:
    //       final contentLength = double.parse(response.headers['x-decompressed-content-length']);
    //   - Another option is to just show the cumulative number of bytes that are being downloaded.
    //     Since the final total is not known, the user still won’t know how long they have to wait,
    //     but at least it will be more informative than an eternal spinning circle.

    /// Now that we have response from server, stop the spinning indicator & set it to 0
    setState(() {
      progress = 0.000001;
      status = "دانلود شروع شد";
    });

    /// Initialize variable to save the download in.
    /// Array stores the file in memory before you save to storage.
    /// Since the length of this array is the number of bytes that have been
    /// downloaded, use this to track the progress of the download.
    List<int> bytes = [];

    /// place to store the file
    final file = await _getFile('${widget.code}.mp3');

    response.stream.listen(
          (List<int> newBytes) {
        // update progress
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        setState(() {
          progress = downloadedLength.toDouble() / (contentLength ?? 1);
          status = "  پیشرفت ${((progress ?? 0)*100).toStringAsFixed(2)}% ";
        });
        print("progress: $progress");
      },
      onDone: () async {
        // save file
        setState(() {
          progress = 1;
          status = "دانلود تکمیل شد";
        });
        await file.writeAsBytes(bytes);
        final duration = await _player.setFilePath('${globals.cacheAudio}/${widget.code}.mp3');

        /// file has been downloaded
        /// show success to user
        debugPrint("Download finished");
      },
      onError: (e) {
        /// if user loses internet connection while downloading the file, causes an error.
        /// You can decide what to do about that in onError.
        /// Setting cancelOnError to true will cause the StreamSubscription to get canceled.
        debugPrint(e);
      },
      cancelOnError: true,
    );

    /// using Flutter package "dio":
    //      Dio dio = Dio();
    //      dio.download(urlOfFileToDownload, '$dir/$filename',
    //         onReceiveProgress(received,total) {
    //         setState(() {
    //           int percentage = ((received / total) * 100).floor();
    //         });
    //      });


  }

  /// Finds an appropriate place on the user’s device to put the file.
  /// In this case we are choosing to use the temp directory.
  /// You could also chose the documents directory or somewhere else.
  /// This method is using the path_provider package to get that location.
  Future<File> _getFile(String filename) async {
    final dir = await getTemporaryDirectory();
    // final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$filename");
  }


  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);
    ui.edameFarazSet==true?WidgetsBinding.instance.addPostFrameCallback((_) {_scrollToPixel();ui.edameFarazSet=false;} ):null;
    bool audioIsSaved=File("data/user/0/pydart.mafatih/cache/${widget.code}.mp3").existsSync();
// print("//////////////////////////////////////////////////// audioIsSaved   $audioIsSaved");
//     print("//////////////////////////////////////////////////// progress   $progress");

    return
//      WillPopScope(
//      onWillPop: _onBackPressed,
//      onWillPop: () async => true,

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
          icon: const Icon(Icons.play_arrow),
          iconSize: 50.0,
          onPressed:
          progress==null ? _downloadButtonPressed : null,

        ),
                if (progress!=null && progress!=0 && progress<1) CircularProgressIndicator(
                  value: progress,
                ),
                if (progress!=null && progress!=0 && progress<1) SizedBox(height: 20,),
                if (progress!=null && progress!=0 && progress<1) Text(status),
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
          preferredSize: Size(0.0, 100.0),
        ):null,
        title: Center(

            // child: Text(
            //   widget.detail,
            //   style: AppStyle.titleupdetailsec,
            // ),
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
      body: FutureBuilder<DailyDoa>(
        future: ServiceData().loadSec(widget.indexFasl, globals.tarjKhati==true && khatiedDoa.contains(1000 *widget.indexFasl + widget.index) ? (1000 *widget.indexFasl + widget.index).toString() : widget.index.toString() ),
        builder: (c, snapshot) {
          if (snapshot.hasData) {
            getOtherSettings();
            titleCurrentPage = snapshot.data.title;
            globals.titleCurrentPage = titleCurrentPage;
            indexCurrentPage = snapshot.data.number;
            globals.indexCurrentPage = indexCurrentPage;
            indexFaslCurrentPage = snapshot.data.bab;
            globals.indexFaslCurrentPage = indexFaslCurrentPage;
            codeCurrentPage = indexFaslCurrentPage * 1000 + indexCurrentPage;
            globals.codeCurrentPage = codeCurrentPage;
          }

          globals.edameFaraz==true?globals.edameFaraz=false:globals.edameFaraz=false;
          return snapshot.hasData
              ? Column(children: <Widget>[
//             globals.lastScrolledPixel!=_scrollPosition && globals.lastScrolledPixel>100 && globals.indexlastViewedPage==widget.index ? Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                     child: const Text('ادامه فراز',                                            style: TextStyle(
// //                                            fontWeight: FontWeight.bold,
//                         fontFamily: 'IRANSans',
//                         fontSize: 14,
//                         height: 1.7,
// //                                            color:
// //                                                Theme.of(context).buttonColor),
//                         color: Color(0xf6c40c0c)),
//                     ),
//                     onPressed: () async {
//                       getLastScolledPixel();
//                       SchedulerBinding.instance?.addPostFrameCallback((_) {
//                         _scrollToPixel();
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).brightness == Brightness.light
//                           ? Colors.grey[400]
//                           : Colors.grey[500],
//
//                     )),
//
//
//               ],
//             ):SizedBox(),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.arabic.length,
                        shrinkWrap: true,
//                        itemExtent: 1000,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext c, int i) {
                          String key = snapshot.data.arabic.keys.elementAt(i);
                          // return Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 15.0, vertical: 5.0),
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Column(
                                    children: <Widget>[
                                      if (snapshot.data.tozih[key] != "" &&
                                          snapshot.data.tozih[key] !=
                                              null) //ui.tafsir &&
                                        ListTile(
                                            dense: true,

//                                      title:  Text(
//                                        '${snapshot.data.tozih[key]}',
//                                        textAlign: TextAlign.justify,
//                                        style: TextStyle(
//                                          fontFamily: 'AdobeArabic-Regular',
////                                          fontSize: ui.fontSizeTozih,
//                                          fontSize: globals.fontTozihLevel,
//                                          height: 1.5,
//                                        ),
//                                      ),

                                            title: RichText(
                                              textAlign: TextAlign.justify,
                                              text: TextSpan(
                                                children:
                                                    highlightOccurrencesDetailSec(
                                                        snapshot
                                                            .data.tozih[key],
                                                        widget.query,
                                                        globals.fontTozihLevel +
                                                            4),
                                                style: TextStyle(
//                                            fontWeight: FontWeight.bold,
                                                    fontFamily: 'عربی ساده',
                                                    fontSize:
                                                        globals.fontTozihLevel,
                                                    height: 1.5,
//                                            color:
//                                                Theme.of(context).buttonColor),
                                                    color: snapshot.data
                                                            .arabic["1"].isEmpty
                                                        ? Theme.of(context)
                                                            .accentColor
                                                        : Theme.of(context)
                                                            .buttonColor),
                                              ),
                                            )),

                                      if (snapshot.data.arabic[key] != "" &&
                                          snapshot.data.arabic[key] != null &&
                                          widget.indexFasl == 4)
                                        ListTile(
                                          dense: true,
                                          title: RichText(
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              children:
                                                  highlightOccurrencesDetailSec(
                                                      snapshot.data
                                                              .arabic[key] +
                                                          "(" +
                                                          (key).toString() +
                                                          ")",
                                                      widget.query,
                                                      globals.fontArabicLevel +
                                                          4),
                                              style: TextStyle(
                                                fontFamily: globals.fontArabic,
                                                fontSize:
                                                    globals.fontArabicLevel,
                                                height: 1.5,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ),
                                        ),

                                      if (snapshot.data.arabic[key] != "" &&
                                          snapshot.data.arabic[key] != null &&
                                          widget.indexFasl != 4)
                                        ListTile(
                                          dense: true,

                                          // leading: Text(
                                          //   snapshot.data.arabic.keys.elementAt(i),
                                          //   style: AppStyle.number,
                                          // ),
//                                      title: Text(
//                                        '${snapshot.data.arabic[key]}',
//                                        textAlign: TextAlign.justify,
//                                        style: TextStyle(
//                                          fontFamily: 'Neirizi',
////                                        fontSize: ui.fontSize,
//                                          fontSize: globals.fontArabicLevel,
//
////                                        fontWeight: FontWeight.w600,
//                                          height: 2.5,
//                                        ),
//                                      ),

                                          title: RichText(
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              children:
                                                  highlightOccurrencesDetailSec(
                                                      snapshot.data.arabic[key],
                                                      widget.query,
                                                      globals.fontArabicLevel +
                                                          4),
                                              style: TextStyle(
                                                fontFamily: globals.fontArabic,
                                                fontSize:
                                                    globals.fontArabicLevel,
                                                height: globals.fontArabic ==
                                                            "نیریزی یک" ||
                                                        globals.fontArabic ==
                                                            "نیریزی دو"
                                                    ? 2.30 // نه حرف من نه حرف اچ جی 2.30 والسلام
                                                    : 2,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ),
                                        ),
//                                  AppStyle.spaceH10,

                                      if (ui.terjemahan &&
                                          snapshot.data.farsi[key] != null &&
                                          snapshot.data.farsi[key] != "")
//                                Text(
//                                  'ترجمه',
//                                  style: AppStyle.end2subtitle,
//                                ),
                                        ListTile(
                                          dense: true,

//                                      title: Text(
//                                        '${snapshot.data.farsi[key]}',
//                                        textAlign: TextAlign.justify,
//                                        style: TextStyle(
//                                          fontFamily: 'AdobeArabic-Regular',
////                                          fontSize: ui.fontSizetext,
//                                          fontSize: globals.fontTarjLevel,
//                                          height: 1.5,
//                                        ),
//                                      ),

                                          title: RichText(
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              children:
                                                  highlightOccurrencesDetailSec(
                                                      snapshot.data.farsi[key],
                                                      widget.query,
                                                      globals.fontTarjLevel +
                                                          4),
                                              style: TextStyle(
                                                fontFamily: 'عربی ساده',
                                                fontSize: globals.fontTarjLevel,
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
      ),
      // bottomNavigationBar: AdmobBanner(
      //   adUnitId: 'ca-app-pub-5524959616213219/7557264464',
      //   adSize: AdmobBannerSize.BANNER,
      //   // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
      //   //   if (event == AdmobAdEvent.clicked) {}
      //   // },
      // ),
    );
  }
}
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player, {Key key}) : super(key: key);
  // int _jsonCode=1000 *globals.indexFaslCurrentPage + globals.indexCurrentPage;
  final audioUrl = "https://www.videoir.com/apps_versions/audios/ashoura/1110.mp3";
  // var dio = Dio();

  // @override
  // void initState() {
  //   int _jsonCode=1000 *globals.indexFaslCurrentPage + globals.indexCurrentPage;
  //   _init(_jsonCode);
  //   print("////////////////////////////////////.........................download2 ");
  //
  //   download2(dio, audioUrl);
  //
  // }

  Future<void> _init(jsonCode) async {
    print("////////////////////////////////////.........................// _init Playing controls ");
    try {
      print("////////////////////////////////////.........................// setAudioSource   ${Constants.audiosListUrl}$jsonCode.mp3'");
      await player.setLoopMode(LoopMode.off);        // Set playlist to loop (off|all|one)
      final audioSource = LockCachingAudioSource(Uri.parse('${Constants.audiosListUrl}/$jsonCode.mp3'));
      await player.setAudioSource(audioSource);
    } catch (e, stackTrace) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      print(stackTrace);
    }
  }

  // void showDownloadProgress(received, total) {
  //   if (total != -1) {
  //     print((received / total * 100).toStringAsFixed(0) + "%");
  //   }
  // }
  // Future download2(Dio dio, String url) async {
  //
  //     var directory = await getTemporaryDirectory();
  //     String savePath = directory.path + "/just_audio_cache/assets/sounds/1117.mp3";
  //     print('*************************************************************************   full path ${savePath}');
  //
  //
  //   try {
  //     Response response = await dio.get(
  //       url,
  //       onReceiveProgress: showDownloadProgress,
  //       //Received data with List<int>
  //       options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status < 500;
  //           }),
  //     );
  //     print(response.headers);
  //     File file = File(savePath);
  //     var raf = file.openSync(mode: FileMode.write);
  //     // response.data is List<int> type
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future playAudio() async {
  //   final file = new File('${(await getTemporaryDirectory()).path}/1110.mp3');
  //   final result = await audioPlayer.play(file.path, isLocal: true);
  // }


  @override
  Widget build(BuildContext context) {
    // String tempsound = globals.sound;
    var ui = Provider.of<UiState>(context);


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
                // download2(dio, audioUrl);

                // showSliderDialog(
                //   context: context,
                //   title: "تنظیم سرعت",
                //   divisions: 20,
                //   min: 0.1,
                //   max: 1.9,
                //   stream: player.speedStream,
                //   onChanged: player.setSpeed, value: player.speed,
                // );
              },
            ),
          ),
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              // print("*******************************************                  ${LockCachingAudioSource(Uri.parse('${Constants.audiosListUrl}/1110.mp3'))}"  );
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
