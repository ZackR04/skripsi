import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/authentication/presentation/ui/register_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  var dio = Dio();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String msg_error = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _showLoading = false;
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
            Padding(padding: EdgeInsets.only(top: 16 )),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(msg_error, style: TextStyle(color: Colors.red, fontSize: 11),),
            ),
            _usernameField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _passwordField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _showLoading ? CircularProgressIndicator() : _buttonSubmit(),
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
            setState(() {
              _showLoading = true;
            });
            _loginProses(username.text, password.text);
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

  void _loginProses(String _username, String _password) async {

   if(_username == ''){
     setState(() {
       _showLoading = false;
       msg_error = "Username harus diisi";
     });
   }
   else if (_password == ''){
     setState(() {
       _showLoading = false;
       msg_error = "Password harus diisi";
     });
   }
   else{
     var formData = FormData.fromMap({
       'username': _username,
       'password': _password
     });

     final response = await dio.post(
       'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiAuthentication/login',
       data: formData
     );

     if(response.statusCode == 200){
       var data = json.decode(response.data);
       if(data['status_message'] == 'success'){
         if (data['accept'] == '0'){
           setState(() {
             _showLoading = false;
             msg_error = "Maaf ${data['nama']}, akun anda belum disetujui oleh admin";
           });
         } else if (data['accept'] == '2'){
           setState(() {
             _showLoading = false;
             msg_error = "Maaf ${data['nama']}, pembuatan akun anda ditolak oleh admin. Silahkan ulangi pembuatan akun anda";
           });
         } else{
           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setString('id', data['id']);
           prefs.setString('nama', data['nama']);
           prefs.setString('username', data['username']);
           prefs.setString('password', data['password']);
           prefs.setString('no_hp', data['no_hp']);
           prefs.setString('nik', data['nik']);
           prefs.setString('status', data['status']);
           prefs.setBool('isLogin', data['isLogin']);
           print('DATA SEASON: ${prefs.getString('id')}');
           if(data['status'] == 'Petugas'){
             Navigator.pushReplacementNamed(context, '/homepetugas');
           }else{
             Navigator.pushReplacementNamed(context, '/home');
           }
         }
       }else{
         setState(() {
           _showLoading = false;
           msg_error = "Maaf, username atau password salah";
         });
       }
     }else{
       setState(() {
         _showLoading = false;
         msg_error = "Maaf, system sedang error";
       });
     }
   }
  }
}
