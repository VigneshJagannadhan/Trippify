import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trippify/features/auth/repository/auth_repo.dart';
import 'package:trippify/features/auth/view_models/auth.viewmodel.dart';
import 'package:trippify/features/home/repository/home_repo.dart';
import 'package:trippify/features/home/view_models/home.viewmodel.dart';
import 'package:trippify/features/trips/repository/trip_repo.dart';
import 'package:trippify/features/trips/view_models/trip.viewmodel.dart';
import '../features/maps/view_models/location_provider.dart';
import '../shared/helpers/locator.dart';

List<SingleChildWidget> get appProviders => [
      ChangeNotifierProvider(
        create: (context) => LocationProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeViewModel(repo: locator<HomeRepo>()),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthViewModel(repo: locator<AuthRepo>()),
      ),
      ChangeNotifierProvider(
        create: (context) => TripViewmodel(repo: locator<TripRepo>()),
      ),
    ];
