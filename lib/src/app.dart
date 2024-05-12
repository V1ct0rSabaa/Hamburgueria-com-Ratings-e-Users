import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/src/views/item_details_view.dart';
import '/src/views/item_list_view.dart';
import 'screens/AuthScreen.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController,});

  final SettingsController settingsController;
  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp. The ListenableBuilder Widget listens to the SettingsController for changes
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [ Locale('en', ''), ],
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          home: const AuthScreen(),
           onGenerateRoute: (RouteSettings routeSettings) {
             return MaterialPageRoute<void>(
               settings: routeSettings,
               builder: (BuildContext context) {
                 switch (routeSettings.name) {
                   case SettingsView.routeName:
                     return SettingsView(controller: settingsController);
                   case ItemDetailsView.routeName:
                     return const ItemDetailsView();
                   case ItemListView.routeName:
                     return const ItemListView();
                   default:
                      return const ItemListView();
                 }
               },
             );
           },
        );
      },
    );
  }
  
}


