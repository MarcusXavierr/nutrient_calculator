import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/download_food_list_data.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/download_food_tracker_data.dart';
part 'download_data_controller.g.dart';

class DownloadDataController = _DownloadDataControllerBase
    with _$DownloadDataController;

abstract class _DownloadDataControllerBase with Store {
  final DownloadFoodListData downloadFoodListData;
  final DownloadFoodTrackerData downloadFoodTrackerData;

  _DownloadDataControllerBase({
    @required this.downloadFoodTrackerData,
    @required this.downloadFoodListData,
  });

  @observable
  bool isLoading = false;

  @action
  setIsLoading(bool value) => this.isLoading = value;

  @observable
  String message;

  @action
  setMessage(String value) => this.message = value;
  @observable
  bool isLoaded = false;

  @action
  setIsLoaded(bool value) => this.isLoaded = value;

  @observable
  Color color;

  @action
  setColor(Color value) => this.color = value;

  downloadFoodList() async {
    setIsLoading(true);
    String userId = GetIt.I.get<FirebaseAuth>().currentUser.uid;
    final result = await downloadFoodListData.call(userId);
    setIsLoading(false);
    result.fold((failure) {
      setColor(kErrorColor);
      setMessage(failure.message);
      setIsLoaded(true);
    }, (success) {
      setColor(kPrimaryColor);
      setMessage(success.message);
      setIsLoaded(true);
    });
  }

  downloadFoodTracker() async {
    setIsLoading(true);
    String userId = GetIt.I.get<FirebaseAuth>().currentUser.uid;
    final result = await downloadFoodTrackerData.call(userId);
    setIsLoading(false);
    result.fold((failure) {
      setColor(kErrorColor);
      setMessage(failure.message);
      setIsLoaded(true);
    }, (success) {
      setColor(kPrimaryColor);
      setMessage(success.message);
      setIsLoaded(true);
    });
  }
}
