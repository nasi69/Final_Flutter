import 'package:flutter/material.dart';
import 'todo_login_logic.dart';
import 'todo_splashscreen.dart';
import 'package:provider/provider.dart';

Widget TodoProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TodoLoginLogic()),
    ],
    child:  TodoSplashScreen(),
  );
}
