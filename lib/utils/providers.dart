import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trippify/features/trips/controllers/trip_provider.dart';

List<SingleChildWidget> appProviders() {
  return [
    // ChangeNotifierProvider(
    //   create: (context) => AuthProvider(),
    // ),
    ChangeNotifierProvider(
      create: (context) => TripProvider(),
    ),
    // ChangeNotifierProvider(
    //   create: (context) => GeminiProvider(),
    // )
  ];
}
