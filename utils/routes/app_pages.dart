import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/auth_controller.dart';
import 'package:iwl/pages/auth/controller/forget_controller.dart';
import 'package:iwl/pages/auth/controller/register_controller.dart';
import 'package:iwl/pages/auth/forget_password.dart';
import 'package:iwl/pages/auth/login.dart';
import 'package:iwl/pages/auth/otp.dart';
import 'package:iwl/pages/auth/register/1register.dart';
import 'package:iwl/pages/auth/register/2good_hands.dart';
import 'package:iwl/pages/auth/register/3setting_up_program.dart';
import 'package:iwl/pages/auth/register/4health_conditions.dart';
import 'package:iwl/pages/auth/register/5journey.dart';
import 'package:iwl/pages/auth/register/6happy.dart';
import 'package:iwl/pages/auth/register/7describe.dart';
import 'package:iwl/pages/auth/register/8focus_on.dart';
import 'package:iwl/pages/auth/register/plan.dart';
import 'package:iwl/pages/dashboard/dashboard_controller.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/daily/controller/daily_controller.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/add_measurement.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/controller/measure_controller.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/claim_rewards.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/controller/overview_controller.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/rewards.dart';
import 'package:iwl/pages/home/home.dart';
import 'package:iwl/pages/home/home_controller.dart';
import 'package:iwl/pages/introduction/introduction.dart';
import 'package:iwl/pages/introduction/introduction_controller.dart';
import 'package:iwl/pages/sidebar/faq/faq_detail.dart';
import 'package:iwl/pages/sidebar/live_coaching/coaching_chat_page.dart';
import 'package:iwl/pages/sidebar/live_coaching/live_coaching_controller.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/health/health_detail_page.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/waist/waist_detail_page.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/weight/weight_detail_page.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tracker_controller.dart';
import 'package:iwl/pages/sidebar/recipes/recipes_detail.dart';
import 'package:iwl/pages/sidebar/resources/resources_pdf.dart';
import 'package:iwl/pages/sidebar/setting/help/help.dart';
import 'package:iwl/pages/sidebar/setting/my_profile/profile.dart';
import 'package:iwl/pages/sidebar/setting/notification/notification_setting.dart';
import 'package:iwl/pages/sidebar/setting/notification/notifications.dart';
import 'package:iwl/pages/sidebar/setting/password/password.dart';
import 'package:iwl/pages/sidebar/setting/program_settings/program_setting.dart';
import 'package:iwl/pages/splash/splash.dart';
import 'package:iwl/pages/videoPlayer/video.dart';
import 'package:iwl/pages/videoPlayer/video_controller.dart';
import 'package:iwl/utils/success_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<IntroductionController>(() => IntroductionController());
      }),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: _Paths.FORGET,
      page: () => ForgetPasswordPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ForgetController>(() => ForgetController());
      }),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.GOOD_HANDS,
      page: () => GoodHandsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.SETTING_UP_PROGRAM,
      page: () => SettingUpProgramPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.HEALTH_CONDITIONS,
      page: () => HealthConditionsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.DESCRIBE,
      page: () => DescribePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.JOURNEY,
      page: () => JourneyPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.HAPPY,
      page: () => HappyPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.FOCUS_ON,
      page: () => FocusOnPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.PLAN,
      page: () => PlanPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
        Get.lazyPut<DashboardController>(() => DashboardController());
        Get.lazyPut<OverviewController>(() => OverviewController());
        Get.lazyPut<DailyController>(() => DailyController());
        Get.lazyPut<MeasureController>(() => MeasureController());

        Get.lazyPut<ProgressTrackerController>(
            () => ProgressTrackerController());
        // Get.lazyPut<HabitController>(() => HabitController());
        // Get.lazyPut<WeightController>(() => WeightController());
        // Get.lazyPut<WaistController>(() => WaistController());
        // Get.lazyPut<HealthController>(() => HealthController());
        // Get.lazyPut<CommentsController>(() => CommentsController());
      }),
    ),
    GetPage(
      name: _Paths.COACHING_CHAT,
      page: () => CoachingChatPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LiveCoachingController>(() => LiveCoachingController());
      }),
    ),
    GetPage(
      name: _Paths.VIDEO,
      page: () => VideoPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<VideoController>(() => VideoController());
      }),
    ),
    GetPage(
      name: _Paths.REWARD,
      page: () => RewardsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OverviewController>(() => OverviewController());
      }),
    ),
    GetPage(
      name: _Paths.CLAIM_REWARD,
      page: () => RewardsClaimPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OverviewController>(() => OverviewController());
      }),
    ),
    GetPage(name: _Paths.SUCCESS, page: () => SuccessPage()),
    GetPage(name: _Paths.ADD_MEASURE, page: () => AddMeasurementPage()),
    GetPage(name: _Paths.RESOURCE_PDF, page: () => ResourcesPdfPage()),
    GetPage(name: _Paths.FAQ_DETAIL, page: () => FaqDetailPage()),
    GetPage(name: _Paths.RECIPE_DETAIL, page: () => RecipesDetailPage()),
    GetPage(name: _Paths.WEIGHT_DETAIL_PAGE, page: () => WeightDetailPage()),
    GetPage(name: _Paths.WAIST_DETAIL_PAGE, page: () => WaistDetailPage()),
    GetPage(name: _Paths.HEALTH_DETAIL_PAGE, page: () => HealthDetailPage()),
    GetPage(name: _Paths.PROFILE_PAGE, page: () => ProfilePage()),
    GetPage(
        name: _Paths.PROGRAM_SETTING_PAGE, page: () => ProgramSettingPage()),
    GetPage(
        name: _Paths.NOTIFICATION_SETTING_PAGE,
        page: () => NotificationSettingPage()),
    GetPage(name: _Paths.CHANGE_PASSWORD_PAGE, page: () => PasswordPage()),
    GetPage(name: _Paths.HELP_PAGE, page: () => HelpPage()),
    GetPage(name: _Paths.NOTIFICATION_PAGE, page: () => NotificationPage()),
  ];
}
