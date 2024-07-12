import 'package:flutter_config/flutter_config.dart';

String lottieRoute = 'assets/lotties';
String svgRoute = 'assets/svgs';
String imageRoute = 'assets/images';

class AppConstants {
  static String appLogo = '$imageRoute/app_logo/trippify_logo_2.png';
  static String? gmapsApiKey = FlutterConfig.get('GOOGLE_MAPS_API_KEY');

  // Formats
  static String dateFormatDateTime = 'EE, dd-MMM-yyyy';

  // Dummy Assets
  static String dummyTripImage = '$imageRoute/app_logo/trippify_logo_2.png';
  static String dummyPersonImage = '$imageRoute/person-dummy.jpg';

  // Svg Assets
  static String homeSvg = '$svgRoute/home.svg';
  static String chatSvg = '$svgRoute/chat.svg';
  static String myTripsSvg = '$svgRoute/my_trips.svg';
  static String profileSvg = '$svgRoute/profile.svg';
  static String createTripSvg = '$svgRoute/create_trip.svg';

  // Lottie Assets
  static String wrongPasswordLottie = '$lottieRoute/wrong-password-lottie.json';
  static String commonErrorsLottie = '$lottieRoute/common-errors-lottie.json';
  static String splashScreenLottie = '$lottieRoute/splash.json';
  static String splashScreenLottie2 = '$lottieRoute/splash2.json';
  static String splashScreenLottie3 = '$lottieRoute/splash3.json';
  static String splashScreenLottie4 = '$lottieRoute/splash4.json';
  static String nothingToSeeHereLottie =
      '$lottieRoute/nothing-to-see-here-lottie.json';
  static String personLottie = '$lottieRoute/person-lottie.json';
}
