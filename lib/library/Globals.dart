library mafatih.globals;

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

bool audioExist=false;
// Map<int, List<String>> haveAudio ={1110:['محسن فرهمند', 'میثم مطیعی'], 3153:['علی فانی', 'محسن فرهمند', 'میثم مطیعی', 'شهید قاسم سلیمانی']} ;
// Map<int, List<String>> haveAudio ={} ;
// List haveAudio = [1110];

int _nextMediaId = 0;
String appNameEn="tavasol";

// String filePath="data/user/0/pydart.mafatih/cache/just_audio_cache/assets/assets/sounds/1117.mp3";
String filePath="data/user/0/pydart.mafatih/app_flutter/1112.mp3";
String cacheAudio="/data/data/pydart.mafatih/cache";
String audioUrl = 'https://www.videoir.com/apps_versions/audios/1112.mp3';



final playlist = ConcatenatingAudioSource(children: [
  AudioSource.uri(
    Uri.parse("file:///$filePath"),
    tag: MediaItem(
        id: '${_nextMediaId++}',
    ),
  ),
]);

// data/user/0/pydart.mafatih/app_flutter/1110.mp3
// Define the playlist
// final playlist = {
//   1110:ConcatenatingAudioSource( useLazyPreparation: true, shuffleOrder: DefaultShuffleOrder(),
// children: [
// LockCachingAudioSource(Uri.parse('https://www.videoir.com/apps_versions/audios/1-fani.mp3')),
//   AudioSource.uri(Uri.parse("asset:///assets/sounds/1-fani.mp3")),
//   AudioSource.uri(Uri.parse("asset:///assets/sounds/0.mp3")),
// ]),
//   3153:ConcatenatingAudioSource( useLazyPreparation: true, shuffleOrder: DefaultShuffleOrder(),
//       children: [
//         AudioSource.uri(Uri.parse('https://www.videoir.com/apps_versions/audios/ashoura/1-fani.mp3')),
//         AudioSource.uri(Uri.parse('https://www.videoir.com/apps_versions/audios/ashoura/2-farahmand.mp3')),
//         AudioSource.uri(Uri.parse('https://www.videoir.com/apps_versions/audios/ashoura/3-motiie.mp3')),
//         AudioSource.uri(Uri.parse('https://www.videoir.com/apps_versions/audios/ashoura/4-soleimani.mp3')),
//       ]),
// };


// final audioSource = LockCachingAudioSource(Uri.parse('https://sampleswap.org/mp3/artist/4646/vibesbuilderyahoode_Minute-Quantity--160.mp3'));

// final playlist = ConcatenatingAudioSource(children: [
//   AudioSource.uri(
//     Uri.parse("asset:///assets/sounds/0.mp3"),
//   ),
// ]);


/// -------------- @Global values
/// changes when onChanged Callback
int currentPage;

/// contains bookmarkedPage
// int bookmarkedPage;
double lastScrolledPixel;

/// refer to last viewed page (stored in sharedPreferences)
int lastViewedPage;

/// Default Screen Brightness level [Default value = 0.5] (medium)
double brightnessLevel;
double brightnessLevelDefault;

bool brightnessActive;
// String sound;

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

/// -------------- @Defaults values
/// if bookmarkedPage not defined
/// Default Bookmarked page equals to surat Al-baqara index [Default value =569] (Reversed)
//const DEFAULT_BOOKMARKED_PAGE = 569;
//const DEFAULT_BOOKMARKED_PAGE_title = 'مقدمه';
//const DEFAULT_BOOKMARKED_PAGE_index = 1;
//const DEFAULT_BOOKMARKED_PAGE_indexFasl = 1;

const DEFAULT_BRIGHTNESS_LEVEL = 0.5;

/// -------------- @SharedPreferences Const
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
