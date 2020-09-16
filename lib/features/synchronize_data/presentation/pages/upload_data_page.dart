import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/controllers/home_controller.dart';
import 'package:nutrients/features/login/presentation/pages/components/error_alert_widget.dart';
import 'package:nutrients/features/synchronize_data/presentation/mobx/upload_data_controller.dart';
import 'package:nutrients/features/synchronize_data/presentation/pages/components/sync_button_widget.dart';
import 'package:nutrients/view-models/home_food_view_model.dart';

class UploadDataPage extends StatelessWidget {
  final _controller = GetIt.I.get<UploadDataController>();
  final _homeController = GetIt.I.get<HomeController>();
  final _homeViewModel = GetIt.I.get<HomeFoodViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload page'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        child: Observer(
          builder: (_) {
            if (_controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SyncButtonWidget(
                  title: 'Upload your food list',
                  text:
                      'This button goes up all the food you have registered for the cloud',
                  function: () async {
                    await _controller.uploadFoodList();
                    if (_controller.isLoaded) {
                      await errorAlertWidget(
                        _controller.message,
                        context,
                        color: _controller.color,
                      ).show();
                    }
                    await _homeController.getFoods();
                  },
                ),
                SyncButtonWidget(
                  title: 'Upload your calorie intake data',
                  text:
                      'This button uploads the data for all calories you have eaten to the cloud',
                  function: () async {
                    await _controller.uploadFoodTracker();
                    if (_controller.isLoaded) {
                      await errorAlertWidget(
                        _controller.message,
                        context,
                        color: _controller.color,
                      ).show();
                    }
                    await _homeViewModel.setAllValues();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
