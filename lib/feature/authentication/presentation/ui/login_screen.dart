import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skripsi_residencereport/feature/authentication/presentation/ui/register_screen.dart';
import 'package:skripsi_residencereport/feature/user/home/presentation/ui/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String msg = 'Login untuk melanjutkan';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  void _togglevisibility(){
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFormLogin()
    );
  }

 Widget _buildFormLogin() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/ilustrasi_login.png'),
            Text(msg, style: TextStyle(color: Colors.red, fontSize: 11), ),
            Padding(padding: EdgeInsets.only(top: 16 )),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text("Username atau Password salah", style: TextStyle(color: Colors.red, fontSize: 11),),
            ),
            _usernameField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _passwordField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _buttonSubmit(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _textRegister(),
          ],
        ),
      ),
    );
 }

 _usernameField(){
    return TextFormField(
      controller: username,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
    );
 }

  _passwordField() {
    return TextFormField(
      controller: password,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.vpn_key),
        suffixIcon: GestureDetector(
          onTap: (){
            _togglevisibility();
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off
          ),
        ),
      ),
    );
  }

  _buttonSubmit() {
    return Material(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
          color: Color(0xFFD1C9FF),
          elevation: 0,
          padding: EdgeInsets.all(15),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(color: Colors.black54, fontSize: 13),),
              Padding(padding: EdgeInsets.only(left: 5, right: 5)),
              Icon(Icons.login, color: Colors.black54, size: 15,)
            ],
          )
      ),
    );
  }

  _textRegister() {
    return Row(
      children: [
        Text("Don't have an account? ", style: TextStyle(color: Colors.black54, fontSize: 11)),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
          child: Text('Register', style: TextStyle(color: Colors.blue, fontSize: 11)),
        )
      ],
    );
  }
}
