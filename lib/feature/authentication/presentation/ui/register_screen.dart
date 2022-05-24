import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/authentication/presentation/ui/login_screen.dart';

import '../../../petugas/home_pet/presentation/ui/home_screen_pet.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController username = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController nik = new TextEditingController();
  TextEditingController no_handphone = new TextEditingController();
  TextEditingController password = new TextEditingController();

  final GlobalKey<FormState> _formRegKey = GlobalKey<FormState>();

  bool _showPassword = false;
  void _togglevisibility(){
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFormRegister(),
    );
  }

  Widget _buildFormRegister() {
    return Form(
      key: _formRegKey,
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usernameField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _nameField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _nikField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _no_handphoneField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _passwordField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _buttonCreate(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _textlogin(),
          ],
        ),
      ),
    );
  }

  _usernameField() {
    return TextFormField(
      controller: username,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
    );
  }

  _nameField() {
    return TextFormField(
      controller: name,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
    );
  }

  _nikField() {
    return TextFormField(
      controller: nik,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.credit_card),
        labelText: 'NIK',
        border: OutlineInputBorder(),
      ),
    );
  }

  _no_handphoneField() {
    return TextFormField(
      controller: no_handphone,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone_android),
        labelText: 'No.Handphone',
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

  _buttonCreate() {
    return Material(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
          color: Color(0xFFD1C9FF),
          elevation: 0,
          padding: EdgeInsets.all(15),
          onPressed: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenPet()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create an Acount", style: TextStyle(color: Colors.black54, fontSize: 13),),
              Padding(padding: EdgeInsets.only(left: 5, right: 5)),
              Icon(Icons.login, color: Colors.black54, size: 15,)
            ],
          )
      ),
    );
  }

  _textlogin() {
    return Row(
      children: [
        Text("Already have an account? ", style: TextStyle(color: Colors.black54, fontSize: 11)),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text('Login', style: TextStyle(color: Colors.blue, fontSize: 11)),
        )
      ],
    );
  }
}
