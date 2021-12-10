import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store/modules/login.dart';
import 'package:store/shared/cubit/bloc_observer/bloc_observer.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import 'layout/home_screen.dart';
import 'modules/welcome.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  String welcome = CacheHelper.getData(key: 'welcome').toString();
  String token = CacheHelper.getData(key: 'token').toString();
  print(token);
  Widget widget;
  if (welcome != "null") {
    if (token != "null") {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = WelcomeScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  late Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: HexColor('#23323f'),
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: startWidget,
    );
  }
}
