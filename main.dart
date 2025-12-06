import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = AuthService();
  final logged = await auth.isLogged();
  runApp(App(startLogged: logged));
}

class App extends StatelessWidget {
  final bool startLogged;
  const App({super.key, required this.startLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Trade Fácil HC",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: LoginScreen(),
    );
  }
}
