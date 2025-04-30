import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:result/controller_binder.dart';
import 'package:result/ui/screens/home_screen.dart';

class DiuResultApp extends StatelessWidget {
  const DiuResultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blueGrey,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 30)),
          scaffoldBackgroundColor: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
