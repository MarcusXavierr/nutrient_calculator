import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/components/carousel_content.dart';
import 'package:nutrients/components/food_list_widget.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/controllers/home_controller.dart';
import 'package:nutrients/screens/insert_food.dart';
import 'package:nutrients/view-models/home_food_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = GetIt.I.get<HomeController>();

  void func() async {
    await _controller.getFoods();
  }

  HomeFoodViewModel viewModel = GetIt.I.get<HomeFoodViewModel>();

  @override
  void initState() {
    func();
    viewModel.setAllValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // * End of header
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsertFood(),
                ),
              ),
              child: ListTile(
                leading: Icon(Icons.add),
                title: Text('Add food'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.cloud_upload),
              title: Text('Synchonize data'),
            ),

            GestureDetector(
              onTap: () async {
                await GetIt.I.get<FirebaseAuth>().signOut();
              },
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text('Nutrient Calculator'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Center(
              child: CarouselSlider(
                options: kCarouselSliderOptions,
                items: [
                  Observer(
                    builder: (_) {
                      return CarouselContent(
                        text: 'Carbohydrate',
                        value: viewModel.carbo,
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return CarouselContent(
                        value: viewModel.protein,
                        text: 'Protein',
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return CarouselContent(
                        value: viewModel.fat,
                        text: 'Fat',
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: FoodListWidget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
