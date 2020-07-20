import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nutrients/components/carousel_content.dart';

import '../constants.dart';

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
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
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
                        FoodTracker(),
                        FoodTracker(),
                        FoodTracker(),
                        FoodTracker(),
                        FoodTracker(),
                        FoodTracker(),
                        FoodTracker(),
                        FoodTracker(),
                        FoodTracker(),
                        FoodTracker(),
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

class FoodTracker extends StatelessWidget {
  const FoodTracker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              RoundIconButton(
                icon: Icons.add,
                onPressed: () {},
              ),
              SizedBox(width: 7.0),
              RoundIconButton(
                icon: Icons.remove,
                onPressed: () {},
              ),
              SizedBox(width: 10.0),
              Text(
                '5',
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          Expanded(
            child: Text(
              'Comida',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onPressed});

  final Function onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPressed,
      elevation: 5.0,
      constraints: BoxConstraints.tightFor(
        width: 47.0,
        height: 47.0,
      ),
      shape: CircleBorder(),
      fillColor: kPrimaryColor,
    );
  }
}
