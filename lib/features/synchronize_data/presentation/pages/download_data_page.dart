import 'package:flutter/material.dart';
import 'package:nutrients/features/synchronize_data/presentation/pages/components/sync_button_widget.dart';

class DownloadDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download data Page'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SyncButtonWidget(
              title: 'Download food list from cloud',
              text:
                  'This button will download your list of foods that are in the cloud and use it to replace local data, meaning your current foods will be deleted and replaced with the foods that you previously added to the cloud.',
              function: () {
                print('download food list');
              },
            ),
            SyncButtonWidget(
              title: 'Download your calorie intake data',
              text:
                  'This button downloads the calorie data that you have ingested that is in the cloud and uses that data to replace the current local data, that is, the local data will be erased and the data that is in the cloud will be used to replace it.',
              function: () {
                print('Download food tracker');
              },
            ),
          ],
        ),
      ),
    );
  }
}
