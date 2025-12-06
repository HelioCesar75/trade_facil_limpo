import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final user = TextEditingController();
  final pass = TextEditingController();
  final auth = AuthService();
  String error = "";

  void login() async {
    final ok = await auth.login(user.text, pass.text);
    if(ok){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
    } else {
      setState(()=> error="Usuário ou senha inválidos.");
    }
  }

  void register() async {
    final ok = await auth.register(user.text, pass.text);
    if(ok) setState(()=>error="Conta criada! Agora faça login.");
    else setState(()=>error="Erro ao criar conta.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Trade Fácil HC - Login")),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(controller: user, decoration: InputDecoration(labelText:"Usuário"),),
              SizedBox(height:8),
              TextField(controller: pass, decoration: InputDecoration(labelText:"Senha"), obscureText:true),
              SizedBox(height:12),
              if(error.isNotEmpty) Text(error, style: TextStyle(color: Colors.red)),
              SizedBox(height:12),
              Row(
                children:[
                  Expanded(child: ElevatedButton(onPressed: login, child: Text("Entrar"))),
                  SizedBox(width:10),
                  ElevatedButton(onPressed: register, child: Text("Criar"))
                ]
              )
            ],
          ),
        )
    );
  }
}
