import 'package:intl/intl.dart';

const bool DEVELOPER_MODE = false;

//rest_api base url
const String BASE_URL = DEVELOPER_MODE
    ? "BASE URL"
    : "BASE URL";

//JWT secret key
const sharedSecret = "3FtJfdlB2pfdASWlgfgf";

///rest_api end point
const apiCommonDetails = "common-details";
//auth
const apiLogin = "login";
const apiLogout = "logout";
const apiUserDetail = "userdetails";
const apiRequestResetPassword = "request-resetpassword";
//overview
const apiDashboardOverview = "dashboard/overview";
const apiUpdateAccStatement = "dashboard/overview/update/acc-statement";
const apiUpdateNoTreatsTakeAway = "dashboard/overview/notreatstakeaway";
const apiWatchedWeeklyVideo = "dashboard/overview/watchedweeklyvideo";
const apiRewards = "rewards";
const apiClaimRewards = "rewards/claim";


//Preference value
const String prefKeyUserModel = 'prefUserModel';
const String prefKeyToken = 'prefToken';
const String prefIsLogin = 'isLogin';
const String preIsFirstTime = 'isFirstTime';

//date formats
DateFormat viewFormat = DateFormat("MMM dd, yyyy (hh:mm a)");
// DateFormat viewFormatDate = DateFormat("dd/MM/yyyy");
DateFormat viewFormatDateFile = DateFormat("dd_MM_yyyy");
DateFormat viewFormatYear = DateFormat("yyyy");
DateFormat viewFormatMonth = DateFormat("MMMM");
DateFormat viewFormatTime = DateFormat("hh:mm a");
DateFormat apiFormat = DateFormat("yyyy-MM-dd");
DateFormat apiFormatBooking = DateFormat("MMM/dd/yyyy hh:mm a");
DateFormat viewFormatDateTime = DateFormat("MMM dd, yyyy hh:mm a");
DateFormat viewFormatDate = DateFormat("MMM dd, yyyy");
DateFormat apiResponseFormat = DateFormat("EEEE, MMMM dd, yyyy");

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

///fontFamily
const String SFProBold = "SF Pro Bold";
const String SFProMedium = "SF Pro Medium";
const String SFProRegular = "SF Pro Regular";
const String SFProSemiBold = "SF Pro SemiBold";
