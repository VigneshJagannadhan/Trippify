import 'package:get_it/get_it.dart';
import 'package:trippify/features/auth/repository/auth_repo.dart';
import 'package:trippify/features/home/repository/home_repo.dart';
import 'package:trippify/features/trips/repository/trip_repo.dart';

final GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerFactory<HomeRepo>(() => HomeRepoImpl());
  locator.registerFactory<AuthRepo>(() => AuthRepoImpl());
  locator.registerFactory<TripRepo>(() => TripRepoImpl());
}
