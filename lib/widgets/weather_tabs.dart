import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/providers/weather_provider.dart';
import 'package:the_weather_app/widgets/weather_list.dart';

class WeatherTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherTabs = Provider.of<WeatherProvider>(context).allWeather;
    print('weatherTabs.length, ${weatherTabs.length}');
    double tabHeight = 0;
    print("tabHeight $tabHeight");
    return LayoutBuilder(builder: (ctx,constraints){
      print("weatherTabs constraints $constraints");
      return DefaultTabController(
          length: weatherTabs.length, // length of tabs
          initialIndex: 5,
          child: Column(children: <Widget>[
            Container(
              child: TabBar(
                isScrollable: true,
                // labelColor: Colors.green,
                labelColor: Colors.white,
                // indicatorColor: Colors.purple,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  ...weatherTabs.map((e){
                    final tab = Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (e.isImageNetwork &&
                              (e.image != null &&
                                  e.image != "" &&
                                  e.image !=
                                      'assets/weather_status/clear.png'))
                            Image.network(
                              e.image,
                              width: 50,
                              height: 50,
                            ),
                          if (!e.isImageNetwork &&
                              (e.image != null &&
                                  e.image != "" &&
                                  e.image !=
                                      'assets/weather_status/clear.png'))
                            Image.asset(
                              e.image,
                              width: 35,
                              height: 35,
                            ),
                          Column(
                            children: [
                              Text(
                                DateFormat.MMMEd().format(e.date),
                                style: TextStyle(color: Colors.white),
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                      "${double.parse(e.tempMax).toStringAsFixed(1)} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      )),
                                  TextSpan(
                                      text:
                                      "${double.parse(e.tempMin).toStringAsFixed(1)} ",
                                      style:
                                      TextStyle(color: Colors.white)
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                    return tab;
                  })
                ],
              ),
            ),
            Container(
                // height: 150, //height of TabBarView
              height: constraints.maxHeight - 49,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5))),
                child: TabBarView(children: <Widget>[
                  ...weatherTabs
                  // .map((e) => WeatherList(e.weatherTimeline))
                      .map((e) {
                    print("e.date ${e.date}");
                    print("e.weatherTimeline ${e.weatherTimeline.length}");
                    return WeatherList(e.weatherTimeline);
                  }).toList()
                ]))
          ]));
    });
  }
}
