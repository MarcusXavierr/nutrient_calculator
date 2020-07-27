import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nutrients/components/carousel_content.dart';
import 'package:nutrients/components/food_tracker.dart';
import 'package:nutrients/controllers/home_controller.dart';
import 'package:nutrients/models/food_model.dart';
import 'package:nutrients/screens/insert_food.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodModel> foods = [];
  HomeController _controller = HomeController();
  // void func() async {
  //   await _controller.getFoods();
  //   setState(() {});
  // }
  Future<void> getFoods() async {
    foods = await _controller.getFoods();

    try {
      for (var food in foods) {
        //print(food.toJson());
        var foodTracker = FoodTracker(
          counter: 1,
          foodName: food.name,
          fat: food.fat,
          carbo: food.carbo,
          protein: food.protein,
          id: food.id,
        );

        foodTrackerList.add(foodTracker);
      }
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  List<FoodTracker> foodTrackerList = [];

  List<Widget> cards = [
    CarouselContent(
      text: 'Carboidrato',
      value: 50,
    ),
    CarouselContent(
      value: 28,
      text: 'Proteína',
    ),
    CarouselContent(
      value: 18,
      text: 'Gordura',
    ),
  ];

  @override
  void initState() {
    super.initState();
    getFoods();
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
                options: CarouselOptions(
                  disableCenter: false,
                  height: 200,
                  aspectRatio: 2.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: cards,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // children:
                      //TODO: refatorar esse codigo para deixar o menor e mais elegante possivel
                      children: foodTrackerList.length != 0
                          ? foodTrackerList
                          : <Widget>[Container()],
                    ),
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
