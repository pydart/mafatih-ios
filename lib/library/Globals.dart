library mafatih.globals;

/// -------------- @Global values
/// changes when onChanged Callback
int currentPage;

/// contains bookmarkedPage
// int bookmarkedPage;

/// refer to last viewed page (stored in sharedPreferences)
int lastViewedPage;

/// Default Screen Brightness level [Default value = 0.5] (medium)
double brightnessLevel;

String titleCurrentPage;
int indexCurrentPage;
int indexFaslCurrentPage;

String titlelastViewedPage;
int indexlastViewedPage;
int indexFasllastViewedPage;

List<String> titleBookMarked;
List<int> indexBookMarked;
List<int> indexFaslBookMarked;

/// -------------- @Defaults values
/// if bookmarkedPage not defined
/// Default Bookmarked page equals to surat Al-baqara index [Default value =569] (Reversed)
//const DEFAULT_BOOKMARKED_PAGE = 569;
const DEFAULT_BOOKMARKED_PAGE_title = 'مقدمه';
const DEFAULT_BOOKMARKED_PAGE_index = 1;
const DEFAULT_BOOKMARKED_PAGE_indexFasl = 1;

const DEFAULT_BRIGHTNESS_LEVEL = 0.5;

/// -------------- @SharedPreferences Const
const LAST_VIEWED_PAGE_title = 'lastViewedPageTitle';
const LAST_VIEWED_PAGE_index = 'lastViewedPageIndex';
const LAST_VIEWED_PAGE_indexFasl = 'lastViewedPageIndexFasl';

const BRIGHTNESS_LEVEL = 'brightness_level';

const BOOKMARKED_PAGE = 'bookmarkedPage';
const BOOKMARKED_PAGE_title = 'bookmarkedPageTitle';
const BOOKMARKED_PAGE_index = 'bookmarkedPageIndex';
const BOOKMARKED_PAGE_indexFasl = 'bookmarkedPageIndexFasl';

const FontArabic_LEVEL = 'FontArabic_level';
const FontTarj_LEVEL = 'FontTarj_level';
const FontTozih_LEVEL = 'FontTozih_level';

const TarjActive = 'TarjActive';
const TozihActive = 'TozihActive';
const DarkMode = 'DarkMode';


double fontArabicLevel;
double fontTarjLevel;
double fontTozihLevel;

bool tarjActive;
bool tozihActive;
bool darkMode;