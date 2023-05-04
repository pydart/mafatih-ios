library mafatih.globals;

// import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

bool audioExist=false;
int _nextMediaId = 0;
String appNameEn="tavasol";
String filePath="data/user/0/pydart.mafatih/app_flutter/1112.mp3";
String cacheAudio="/data/data/pydart.mafatih/cache";
String audioUrl = 'https://www.videoir.com/apps_versions/audios/1112.mp3';


List<int> khatiedDoa = [
  1110,3153, 1122, 3216, 3224, 1119];


bool isonline;
// final playlist = ConcatenatingAudioSource(children: [
//   AudioSource.uri(
//     Uri.parse("file:///$filePath"),
//     tag: MediaItem(
//         id: '${_nextMediaId++}',
//     ),
//   ),
// ]);

int currentPage;
double lastScrolledPixel;
int lastViewedPage;
double brightnessLevel;
double brightnessLevelDefault;
bool brightnessActive;
String titleCurrentPage;
int indexCurrentPage;
int indexFaslCurrentPage;
int codeCurrentPage;
String titlelastViewedPage;
int indexlastViewedPage;
int indexFasllastViewedPage;
String indentlastViewedPage;
bool edameFaraz;

List<String> titleBookMarked;
List<int> indexBookMarked;
List<int> indexFaslBookMarked;
List<int> codeBookMarked;
List<dynamic> mapBookMarked;
List<String> jsonCodesHavingAudio=[];
String jsonGifAdUrl="";
Map jsonGifAdUrlMap ={
"urlgifdrawer1":"",
"urlgifdrawer2":"",
"urlgifdrawer3":"",

"urlgiffirstpage1":"",
"urlgiffirstpage2":"",
"urlgiffirstpage3":"",

"urlgiffav1":"",
"urlgiffav2":"",
"urlgiffav3":"",

"urlgifsearch1":"",
"urlgifsearch2":"",
"urlgifsearch3":"",
};
// String urlgifdrawer1;
// String urlgifdrawer2;
// String urlgifdrawer3;
// String urlgiffirstpage1;
// String urlgiffirstpage2;
// String urlgiffirstpage3;
// String urlgiffav1;
// String urlgiffav2;
// String urlgiffav3;
// String jsonGifAdUrl;
// String jsonGifAdUrl;
// String jsonGifAdUrl;


const DEFAULT_BRIGHTNESS_LEVEL = 0.5;
const LAST_VIEWED_PAGE_title = 'lastViewedPageTitle';
const LAST_VIEWED_PAGE_index = 'lastViewedPageIndex';
const LAST_VIEWED_PAGE_indexFasl = 'lastViewedPageIndexFasl';
const LAST_SCROLLED_PIXEL = 'lastScrolledPixel';
const LAST_VIEWED_PAGE_indent = 'lastViewedPageIndent';
const BRIGHTNESS_LEVEL = 'brightness_level';
const BrightnessActive = 'BrightnessActive';
const BOOKMARKED_PAGE = 'bookmarkedPage';
const BOOKMARKED_PAGE_title = 'bookmarkedPageTitle';
const BOOKMARKED_PAGE_index = 'bookmarkedPageIndex';
const BOOKMARKED_PAGE_indexFasl = 'bookmarkedPageIndexFasl';
const BOOKMARKED_PAGE_Code = 'bookmarkedPageCode';
const BOOKMARKED_MAP = 'bookmarkedMap';
const FontArabic = 'FontArabic';
const FontArabic_LEVEL = 'FontArabic_level';
const FontTarj_LEVEL = 'FontTarj_level';
const FontTozih_LEVEL = 'FontTozih_level';
const ThemeType = 'ThemeType';
const TarjActive = 'TarjActive';
const TozihActive = 'TozihActive';
const DarkMode = 'DarkMode';
const LaterDialog = 'LaterDialog';
const TarjKhati = 'TarjKhati';
const Sound = 'Sound';
const AudioExist = 'AudioExist';
const JsonCodesHavingAudio = 'JsonCodesHavingAudio';
const JsonGifAdUrl = 'JsonGifAdUrl';
// const EdameFaraz = 'EdameFaraz';



double fontArabicLevel;
double fontTarjLevel;
double fontTozihLevel;
String fontArabic;
bool themeType;

bool tarjActive;
bool tozihActive;
bool darkMode;
bool laterDialog;
bool tarjKhati;
