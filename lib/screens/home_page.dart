import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nutrients/components/carousel_content.dart';
import 'package:nutrients/components/food_tracker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text('Calculadora de nutrientes'),
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
                      children: <Widget>[
                        FoodTracker(
                          counter: 3,
                          foodName: 'Ovo',
                        ),
                        FoodTracker(
                          counter: 1,
                          foodName: 'Peito de frango',
                        ),
                        FoodTracker(
                          counter: 2,
                          foodName: 'Bife de carne bovina',
                        ),
                        FoodTracker(
                          counter: 4,
                          foodName: 'Colher de sopa de arroz integral',
                        ),
                      ],
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
