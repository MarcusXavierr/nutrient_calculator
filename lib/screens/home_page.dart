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

  // List<Widget> cards = [
  //   CarouselContent(
  //     text: 'Carboidrato',
  //     value: 0,
  //   ),
  //   CarouselContent(
  //     value: 28,
  //     text: 'Proteína',
  //   ),
  //   CarouselContent(
  //     value: 18,
  //     text: 'Gordura',
  //   ),
  // ];

  @override
  void initState() {
    func();
    viewModel.setAllValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text('Calculadora de nutrientes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InsertFood(),
              ),
            ),
          ),
        ],
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
                        text: 'Carboidrato',
                        value: viewModel.carbo,
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return CarouselContent(
                        value: viewModel.protein,
                        text: 'Proteína',
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return CarouselContent(
                        value: viewModel.fat,
                        text: 'Gordura',
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
