import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/controllers/home_controller.dart';

import 'package:nutrients/core/network/network_info.dart';
import 'package:nutrients/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:nutrients/features/login/data/repositories/auth_repository_impl.dart';
import 'package:nutrients/features/login/domain/repositories/auth_repository.dart';
import 'package:nutrients/features/login/domain/usecases/create_account_with_email.dart';
import 'package:nutrients/features/login/domain/usecases/login_with_email.dart';
import 'package:nutrients/features/login/domain/usecases/sign_in_with_google.dart';
import 'package:nutrients/features/login/presentation/mobx/create_account_controller.dart';
import 'package:nutrients/features/login/presentation/mobx/login_controller.dart';

import 'package:nutrients/features/synchronize_data/data/datasource/external/food_list_data_source_impl.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/external/food_tracker_data_source_impl.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_list_data_source.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_tracker_data_source.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_database_conn.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/download_food_list_data.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/download_food_tracker_data.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/upload_food_list_data.dart';
import 'package:nutrients/features/synchronize_data/presentation/mobx/download_data_controller.dart';
import 'package:nutrients/features/synchronize_data/presentation/mobx/upload_data_controller.dart';
import 'package:nutrients/mypass.dart';
import 'package:nutrients/view-models/home_food_view_model.dart';
import 'features/synchronize_data/data/datasource/local_storage/food_list_database_conn_impl.dart';
import 'features/synchronize_data/data/repositories/food_list_data_repository_impl.dart';
import 'features/synchronize_data/data/repositories/food_tracker_data_repository_impl.dart';
import 'features/synchronize_data/domain/repositories/food_list_data_repository.dart';
import 'features/synchronize_data/domain/repositories/food_tracker_data_repository.dart';
import 'features/synchronize_data/domain/usecases/upload_food_tracker_data.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Login
  sl.registerSingleton(Firebase.initializeApp());
  featureLogin();

  //! Features - Synchronize
  featureSynchronize();
  //! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  // * Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerFactory(() =>
      HasuraConnect(HasuraUrl, headers: {"x-hasura-admin-secret": myPass}));
}

void featureLogin() {
  //* MOBX
  sl.registerFactory<LoginController>(() => LoginController(
        loginWithEmail: sl(),
        signInWithGoogle: sl(),
      ));

  sl.registerLazySingleton<CreateAccountController>(
      () => CreateAccountController(
            createAccountWithEmail: sl(),
            signInWithGoogle: sl(),
          ));

  sl.registerSingleton<HomeController>(HomeController());

  sl.registerSingleton<HomeFoodViewModel>(HomeFoodViewModel());

  //* Usecases
  sl.registerLazySingleton<LoginWithEmail>(() => LoginWithEmail(sl()));
  sl.registerLazySingleton<CreateAccountWithEmail>(
      () => CreateAccountWithEmail(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));

  // * Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl(), networkInfo: sl()));

  // * Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        auth: sl(),
      ));
}

void featureSynchronize() {
  // * Controllers
  sl.registerLazySingleton<DownloadDataController>(() => DownloadDataController(
      downloadFoodListData: sl(), downloadFoodTrackerData: sl()));

  sl.registerLazySingleton<UploadDataController>(() => UploadDataController(
      uploadFoodListData: sl(), uploadFoodTrackerData: sl()));
  // * Usecases
  sl.registerLazySingleton(() => DownloadFoodTrackerData(sl()));
  sl.registerLazySingleton(() => DownloadFoodListData(sl()));
  sl.registerLazySingleton(() => UploadFoodListData(sl()));
  sl.registerLazySingleton(() => UploadFoodTrackerData(sl()));

  // * Repository
  sl.registerLazySingleton<FoodListDataRepository>(
      () => FoodListDataRepositoryImpl(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<FoodTrackerDataRepository>(
      () => FoodTrackerDataRepositoryImpl(dataSource: sl(), networkInfo: sl()));

  // * Data source
  sl.registerLazySingleton<FoodListDataSource>(() =>
      FoodListDataSourceImpl(foodListTableConn: sl(), hasuraConnect: sl()));
  sl.registerLazySingleton<FoodTrackerDataSource>(() =>
      FoodTrackerDataSourceImpl(hasuraConnect: sl(), foodDatabaseConn: sl()));

  // * Database Connection
  sl.registerLazySingleton<FoodDatabaseConn>(() => FoodListDatabaseConnImpl());
}
