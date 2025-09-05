import 'package:flutter/material.dart';
import 'logged_user_model.dart';
import 'todo_login_logic.dart';
import 'todo_login_screen.dart';
import 'package:provider/provider.dart';

import 'todo_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LoggedUserModel user = context.watch<TodoLoginLogic>().loggedUser;

    debugPrint("Logged user: ${user.toJson()}");

    ThemeMode mode = ThemeMode.system;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: mode,
      home: (user.token == "no_token" || user.token.isEmpty)
          ? const TodoLoginScreen()
          : const TodoScreen(),
    );
  }
}
