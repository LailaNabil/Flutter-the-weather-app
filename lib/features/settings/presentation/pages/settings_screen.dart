import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_weather_app/core/localization/localization.dart';
import 'package:the_weather_app/core/resources/app_colors.dart';
import 'package:the_weather_app/main.dart';
import '../../../language/presentation/bloc/language_bloc.dart';
import '../../../weather/presentation/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final theme = Theme.of(context);
    final orientation = mediaQuery.orientation;
    final isPortrait = screenSize.width < screenSize.height;
    void _toggleLanguage() async{
      // setState(() {
      //   //printDebug('_toggleLanguage');
      // });
      context.setLocale( context.locale == Locale('en', 'UK') ? Locale('ar', 'EG') : Locale(
          'en', 'UK'));
      final languageBloc = BlocProvider.of<LanguageBloc>(context);
      var currentLanguagesEnum = LocalizationImpl().getCurrentLanguagesEnum(context);
      if(currentLanguagesEnum!=null){
        languageBloc.add(SelectLanguage(currentLanguagesEnum));
      }
      analytics.logEvent(name: "ChangeLanguage" ,parameters: {"lang" : context.locale});
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
                    color: AppColors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            backgroundColor: theme.backgroundColor,
            body: Container(
                padding: const EdgeInsets.all(25.0),
                width: screenSize.width,
                height: screenSize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: 'lang'.tr().contains('En') ? CrossAxisAlignment.end:CrossAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () => _toggleLanguage(),
                        icon: Icon(Icons.language),
                        label: Text('change_lang'.tr().toString())),
                    Row(
                      children: [
                        Text(LocalizationImpl().translate("madeWith") +
                            " " +
                            LocalizationImpl().translate("flutter") +
                            " " +
                            LocalizationImpl().translate("by") +
                            " ",style: TextStyle(color: Colors.white),),
                        TextButton(
                            onPressed: () async {
                              analytics.logEvent(name: "launchGithub");
                              await launchUrl(
                                Uri.parse( "https://github.com/laila-nabil/"),
                              );
                            },
                            child: Text(
                                LocalizationImpl().translate("lailaNabil"),style: TextStyle(color: Colors.white)))
                      ],
                    )
                  ],
                ))));
  }
}
