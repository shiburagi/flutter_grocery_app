import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/home.dart';
import 'package:localize/localize.dart';
import 'package:uikit/uikit.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocs,
      child: MaterialApp(
        title: 'Flutter Grocery',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: createTheme(
          fontFamily: "Nunito",
        ),
        themeMode: ThemeMode.system,
        darkTheme: createTheme(
          fontFamily: "Nunito",
          brightness: Brightness.dark,
          cardColor: Colors.blueGrey.shade800,
          canvasColor: (Colors.blueGrey.shade900),
          shadowColor: Colors.black,
        ),
        routes: HomeRoutes.routes,
      ),
    );
  }
}
