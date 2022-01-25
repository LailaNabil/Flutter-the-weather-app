import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/providers/weather_provider.dart';
import 'package:the_weather_app/screens/home_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final theme = Theme.of(context);
    final orientation = mediaQuery.orientation;
    final isPortrait = screenSize.width < screenSize.height;
    void _toggleLanguage() async{
      setState(() {
        context.locale =
        context.locale == Locale('en', 'UK') ? Locale('ar', 'EG') : Locale(
            'en', 'UK');
      });
      Provider.of<WeatherProvider>(context,listen: false).toggleLanguage();
      Navigator.of(context).pushReplacementNamed(MyHomePage.routeName);
    }
    return SafeArea(
        bottom: true,
        left: true,
        top: true,
        right: true,
        maintainBottomViewPadding: true,
        minimum: EdgeInsets.zero,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: theme.backgroundColor,
              elevation: 0,
              title: Text(
                'settings'.tr().toString(),
                style: TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            backgroundColor: theme.backgroundColor,
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: 'lang'.tr().contains('En') ? CrossAxisAlignment.end:CrossAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(onPressed: ()=>_toggleLanguage(), icon: Icon(Icons.language), label: Text('change_lang'.tr().toString()))
                      ],
                    )))));
  }
}
