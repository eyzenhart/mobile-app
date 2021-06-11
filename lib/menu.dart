import 'dart:convert';

import 'package:booking/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Menu extends StatelessWidget {
  Set<List> map_ads = {};

  @override
  Widget build(BuildContext context) {
    // Widget _hello() {
    //   return AppBar(
    //     backgroundColor: Colors.teal[200],
    //     title: Text(
    //       'Добро пожаловать, пользователь!',
    //       style: TextStyle(
    //           fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    //     ),
    //   );
    // }

    // Widget _location() {
    //   return Padding(
    //     padding: EdgeInsets.only(bottom: 50),
    //     child: Container(
    //       width: 350,
    //       color: Colors.teal[800],
    //       child: Padding(
    //         padding: EdgeInsets.only(top: 30, bottom: 30),
    //         child: Align(
    //             child: Text(
    //           'Москва, Замоскворечье',
    //           style: TextStyle(fontSize: 24, color: Colors.white),
    //         )),
    //       ),
    //     ),
    //   );
    // }

    Widget _card(String title, String description) {
      return Container(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                Text(description, style: TextStyle(color: Colors.white))
              ],
            )),
        color: Colors.teal[800],
      );
    }

    // Future loadAds() async {
    //   var jsonData = await rootBundle.loadString('assets/ads.json');
    //   var data = json.decode(jsonData);
    //   data['advert'].forEach((item) {
    //     map_ads.add(item);
    //   });
    // }

    Widget _user_cards() {
      return Padding(
          padding: EdgeInsets.only(bottom: 150),
          child: Align(
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal[800],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.teal[200], spreadRadius: 3),
                      ],
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(children: <Widget>[
                          new Image.asset(
                            'assets/images/ads1.jpg',
                            width: 150,
                            height: 120,
                          ),
                          new Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Уютная квартира рядом с МИРЭA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )))
                        ]))),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal[800],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.teal[200], spreadRadius: 3),
                      ],
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(children: <Widget>[
                          new Image.asset(
                            'assets/images/ads2.jpg',
                            width: 150,
                            height: 120,
                          ),
                          new Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text('Просторные апартаменты',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ))))
                        ]))),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal[800],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.teal[200], spreadRadius: 3),
                      ],
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(children: <Widget>[
                          new Image.asset(
                            'assets/images/ads3.jpg',
                            width: 150,
                            height: 120,
                          ),
                          new Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Красивая студия для небольшой семьи',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )))
                        ])))
              ],
            ),
          ));
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10, left: 10),
                child: Text(
                  'Понравившиеся объявления:',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
            _user_cards(),
          ],
        )),
        backgroundColor: Colors.blueGrey[900]);
  }
}
