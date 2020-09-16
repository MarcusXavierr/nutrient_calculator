import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/controllers/home_controller.dart';
import 'package:nutrients/features/login/presentation/pages/components/error_alert_widget.dart';
import 'package:nutrients/features/synchronize_data/presentation/mobx/download_data_controller.dart';
import 'package:nutrients/features/synchronize_data/presentation/pages/components/sync_button_widget.dart';
import 'package:nutrients/view-models/home_food_view_model.dart';

class DownloadDataPage extends StatelessWidget {
  final DownloadDataController _controller =
      GetIt.I.get<DownloadDataController>();

  final _homeController = GetIt.I.get<HomeController>();
  final _homeViewModel = GetIt.I.get<HomeFoodViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download data Page'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
        child: Observer(
          builder: (_) {
            if (_controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SyncButtonWidget(
                    title: 'Download food list from cloud',
                    text:
                        'This button will download your list of foods that are in the cloud and use it to replace local data, meaning your current foods will be deleted and replaced with the foods that you previously added to the cloud.',
                    function: () async {
                      await _controller.downloadFoodList();
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
                    title: 'Download your calorie intake data',
                    text:
                        'This button downloads the calorie data that you have ingested that is in the cloud and uses that data to replace the current local data, that is, the local data will be erased and the data that is in the cloud will be used to replace it.',
                    function: () async {
                      await _controller.downloadFoodTracker();
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
            }
          },
        ),
      ),
    );
  }
}
