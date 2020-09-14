import 'package:flutter/material.dart';
import 'package:nutrients/features/synchronize_data/presentation/pages/components/sync_button_widget.dart';
import 'package:nutrients/features/synchronize_data/presentation/pages/download_data_page.dart';
import 'package:nutrients/features/synchronize_data/presentation/pages/upload_data_page.dart';

class SyncMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sync Main Page'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SyncButtonWidget(
              title: 'Upload data to cloud',
              text:
                  '''You will upload your current data to the cloud and you can use it to recover your data if you change or lose your phone. You will delete your current data in the cloud (if you have one) and replace it with the data currently on your phone''',
              function: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadDataPage()));
              },
            ),
            SyncButtonWidget(
              title: 'Download data from cloud',
              text:
                  '''You will download your data from the cloud and replace the current local data with the downloaded data, that is, your current data will be erased and replaced with data from the cloud.''',
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DownloadDataPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
