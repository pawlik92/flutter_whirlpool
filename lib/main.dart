import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_whirlpool/screens/main/main_screen.dart';
import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
      ],
      child: MaterialApp(
        title: 'Smart Washing Machine',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}
