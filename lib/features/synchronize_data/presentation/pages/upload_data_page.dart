import 'package:flutter/material.dart';
import 'package:nutrients/features/synchronize_data/presentation/pages/components/sync_button_widget.dart';

class UploadDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload page'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SyncButtonWidget(
              title: 'Upload your food list',
              text:
                  'This button goes up all the food you have registered for the cloud',
              function: () {
                print('upload food list');
              },
            ),
            SyncButtonWidget(
              title: 'Upload your calorie intake data',
              text:
                  'This button uploads the data for all calories you have eaten to the cloud',
              function: () {
                print('upload food tracker');
              },
            ),
          ],
        ),
      ),
    );
  }
}
