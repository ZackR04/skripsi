import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            Padding(padding: EdgeInsets.only(top: 16 ),),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text("Username atau Password salah", style: TextStyle(color: Colors.red, fontSize: 11),),
            ),
            Padding(padding: EdgeInsets.only(top: 16)),
            Padding(padding: EdgeInsets.only(top: 16)),
            Padding(padding: EdgeInsets.only(top: 16)),
          ],
        ),
      ),
    );
 }

 _usernameField(){
    // return BlocBuilder(builder: builder)
 }

}
