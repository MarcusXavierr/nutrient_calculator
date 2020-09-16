import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/upload_food_list_data.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/upload_food_tracker_data.dart';

import 'package:mobx/mobx.dart';
part 'upload_data_controller.g.dart';

class UploadDataController = _UploadDataControllerBase
    with _$UploadDataController;

abstract class _UploadDataControllerBase with Store {
  final UploadFoodListData uploadFoodListData;
  final UploadFoodTrackerData uploadFoodTrackerData;

  _UploadDataControllerBase({
    @required this.uploadFoodListData,
    @required this.uploadFoodTrackerData,
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

  uploadFoodList() async {
    setIsLoading(true);
    String userId = GetIt.I.get<FirebaseAuth>().currentUser.uid;
    final result = await uploadFoodListData.call(userId);
    setIsLoading(false);
    result.fold((failure) {
      setColor(kErrorColor);
      setMessage(failure.message);
      setIsLoaded(true);
    }, (success) {
      setColor(kPrimaryColor);
      setMessage(success.message);
      print(success.message);
      setIsLoaded(true);
    });
  }

  uploadFoodTracker() async {
    setIsLoading(true);
    String userId = GetIt.I.get<FirebaseAuth>().currentUser.uid;
    final result = await uploadFoodTrackerData.call(userId);
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
