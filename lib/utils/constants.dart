import 'package:flutter_config/flutter_config.dart';

String lottieRoute = 'assets/lotties';
String svgRoute = 'assets/svgs';
String imageRoute = 'assets/images';

class AppConstants {
  static String appLogo = '$imageRoute/app_logo/trippify_logo_2.png';
  static String? gmapsApiKey = FlutterConfig.get('GOOGLE_MAPS_API_KEY');

  // Assets
  static String homeSvg = '$svgRoute/home.svg';
  static String chatSvg = '$svgRoute/chat.svg';
  static String myTripsSvg = '$svgRoute/my_trips.svg';
  static String profileSvg = '$svgRoute/profile.svg';
  static String createTripSvg = '$svgRoute/create_trip.svg';

  // Lotties
  static String wrongPasswordLottie = '$lottieRoute/wrong-password-lottie.json';
  static String commonErrorsLottie = '$lottieRoute/common-errors-lottie.json';
}
