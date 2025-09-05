import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'todo_login_logic.dart';
import 'todo_service.dart';
import 'package:provider/provider.dart';

import 'logged_user_model.dart';
import 'todo_app.dart';              // ✅ make sure you create/import TodoApp
import 'todo_login_screen.dart';    // ✅ make sure you create/import TodoLoginScreen

class TodoSplashScreen extends StatefulWidget { // ✅ fixed naming
  const TodoSplashScreen({super.key});

  @override
  State<TodoSplashScreen> createState() => _TodoSplashScreenState();
}

class _TodoSplashScreenState extends State<TodoSplashScreen> {
  late Future<int> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _testLoggedUser();
  }

  Future<int> _testLoggedUser() async {
    LoggedUserModel loggedUser =
        await context.read<TodoLoginLogic>().readLoggedUser();
    return TodoService.testToken(loggedUser.token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: FutureBuilder<int>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildError(snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == 200) {
              return const TodoApp(); // ✅ added const
            } else {
              return const TodoLoginScreen();
            }
          } else {
            return _loadingScreen();
          }
        },
      ),
    );
  }

  Widget _loadingScreen() {
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey,
      child: const Icon(Icons.person, color: Colors.white, size: 100),
    );
  }

  Widget _buildError(Object? error) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error),
            Text(error.toString()),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _futureData = _testLoggedUser();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text("RETRY"),
            ),
            error.toString().contains("401")
                ? ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => const TodoLoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Login"),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
