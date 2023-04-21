library mafatih.globals;

import 'package:just_audio/just_audio.dart';


Map<int, List<String>> haveAudio ={1110:['محسن فرهمند', 'میثم مطیعی', 'مهدی سماواتی']} ;
// List haveAudio = [1110];

int _nextMediaId = 0;
String appNameEn="tavasol";

// Define the playlist
final playlist = {1110:ConcatenatingAudioSource(
useLazyPreparation: true,
shuffleOrder: DefaultShuffleOrder(),
children: [
  AudioSource.uri(Uri.parse('https://cdn.pixabay.com/download/audio/2022/01/18/audio_d0a13f69d2.mp3?filename=electronic-rock-king-around-here-15045.mp3')),
  AudioSource.uri(Uri.parse('https://cdn.pixabay.com/download/audio/2021/10/25/audio_47edc456e3.mp3?filename=simple-piano-melody-9834.mp3')),
  AudioSource.uri(Uri.parse('https://cdn.pixabay.com/download/audio/2023/03/16/audio_df7d9198c3.mp3?filename=floating-abstract-142819.mp3')),
],
)};



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
String sound="0";

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
