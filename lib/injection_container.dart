import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
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
import 'package:nutrients/view-models/home_food_view_model.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Login
  sl.registerSingleton(Firebase.initializeApp());

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
  sl.registerLazySingleton(() => LoginWithEmail(sl()));
  sl.registerLazySingleton(() => CreateAccountWithEmail(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));

  // * Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl(), networkInfo: sl()));

  // * Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        auth: sl(),
      ));

  //! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  // * Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
