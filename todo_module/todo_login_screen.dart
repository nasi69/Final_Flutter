import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'todo_login_logic.dart';
import 'todo_screen.dart';
import 'todo_service.dart';
import 'package:provider/provider.dart';

class TodoLoginScreen extends StatefulWidget {
  const TodoLoginScreen({super.key});

  @override
  State<TodoLoginScreen> createState() => _TodoLoginScreenState();
}

class _TodoLoginScreenState extends State<TodoLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _hidePassword = true;

  final _img =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShYwM33sSN7MtnLIq0k1qjhpoEtSstLE26gA&s";

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo(),
                const SizedBox(height: 20),
                _buildEmailTextField(),
                const SizedBox(height: 10),
                _buildPasswordTextField(),
                const SizedBox(height: 20),
                _buildLoginButton(),
                const SizedBox(height: 10),
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return CircleAvatar(
      radius: 70,
      backgroundImage: NetworkImage(_img),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailCtrl,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        hintText: "Enter Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        const pattern =
            r"(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+"
            r"(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*|"
            r'"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]'
            r'|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@'
            r"(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+"
            r"[a-zA-Z]{2,}|\[(?:(?:25[0-5]|2[0-4][0-9]|"
            r"[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|"
            r"[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:"
            r"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]"
            r"|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])";

        final regex = RegExp(pattern);

        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        if (!regex.hasMatch(value)) {
          return 'Enter a valid Email address';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passCtrl,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        hintText: "Enter password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _hidePassword = !_hidePassword;
            });
          },
          icon: Icon(
            _hidePassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      textInputAction: TextInputAction.done,
      obscureText: _hidePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: () async {
        
        if (_formKey.currentState!.validate()) {
          try {
            // ✅ Call login service
            final result = await TodoService.login(
              _emailCtrl.text.toLowerCase().trim(),
              _passCtrl.text.trim(),
            );

            // ✅ Save logged user to provider
            await context.read<TodoLoginLogic>().saveLoggedUser(result);

            if (!mounted) return;

            // ✅ Navigate to main Todo screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TodoScreen()),
            );
          } catch (e) {
            if (!mounted) return;
            // Show error message as a SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        }
      },
      child: const Text("Login"),
    ),
  );
}


  Widget _buildRegisterLink() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RegisterScreen()),
        );
      },
      child: const Text("Register a New Account"),
    );
  }
}
