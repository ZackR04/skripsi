import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/authentication/presentation/ui/login_screen.dart';
import '../../../petugas/home_pet/presentation/ui/home_screen_pet.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String? _valPerusahaan;
  String? _valBlok;
  String? _valNoRumah;
  final List _listBlok = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
  ];
  final List _listNoRumah = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];
  final List _listNamaPerusahaan = [
    "PT. Rapi Jaya",
    "PT. Bersih Abadi",
    "PT. Makmur",
  ];

  var dio = Dio();
  TextEditingController username = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController nik = new TextEditingController();
  TextEditingController no_handphone = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String msg_error = '';

  final GlobalKey<FormState> _formRegKey = GlobalKey<FormState>();

  bool _switchValue=true;
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

      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 70, left: 40, bottom: 10),
                alignment: Alignment.topLeft,
                child: Text('Masuk sebagai Penghuni Perumahan ?'),
              ),
              Container(
                padding: EdgeInsets.only(top: 60, left: 20),
                child: CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
          _buildFormRegister(),
        ],
      )
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
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(msg_error, style: TextStyle(color: Colors.red, fontSize: 11),),
            ),
            _usernameField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _nameField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _nikField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _no_handphoneField(),
            Padding(padding: EdgeInsets.only(top: 16)),
            _passwordField(),
            Padding(padding: EdgeInsets.only(top: 20)),
            _switchValue ? _blokField() : _pilihPerusahaan(),
            Padding(padding: EdgeInsets.only(top: 30)),
            _showLoading ? CircularProgressIndicator() : _buttonCreate(),
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

  _blokField() {
    return Row(
      children: [
        DropdownButton(
          hint: const Text('Blok'),
          value: _valBlok,
          items: _listBlok.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _valBlok = value.toString();
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
        ),
        DropdownButton(
          hint: const Text('No Rumah'),
          value: _valNoRumah,
          items: _listNoRumah.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: (value){
            setState(() {
              _valNoRumah = value.toString();
            });
          },
        ),
      ],
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
            _registerProcess(username.text, name.text, nik.text, no_handphone.text, password.text, _valBlok ,_valNoRumah, _valPerusahaan);
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

  Future<void> _registerProcess(String username, String name, String nik, String no_handphone, String password, var _valBlok, var _valNoRumah, var _valPerusahaan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(username == ''){
      setState(() {
        _showLoading = false;
        msg_error = "Username harus diisi";
      });
    }else if(name == ''){
      setState(() {
        _showLoading = false;
        msg_error = "Nama harus diisi";
      });
    }else if(nik == ''){
      setState(() {
        _showLoading = false;
        msg_error = "NIK harus diisi";
      });
    }else if(no_handphone == ''){
      setState(() {
        _showLoading = false;
        msg_error = "No.Handphone harus diisi";
      });
    }else if(password == ''){
      setState(() {
        _showLoading = false;
        msg_error = "Password harus diisi";
      });
    }else if(_switchValue && _valBlok == null){
      setState(() {
        _showLoading = false;
        msg_error = "Blok harus dipilih";
      });
    }else if(_switchValue && _valNoRumah == null){
      setState(() {
        _showLoading = false;
        msg_error = "No.Rumah harus dipilih";
      });
    }else if (!_switchValue && _valPerusahaan == null) {
      setState(() {
        _showLoading = false;
        msg_error = "Pilih perusahaan anda";
      });
    }else{
      var formData = FormData.fromMap({
        'username': username,
        'nama': name,
        'nik': nik,
        'no_hp': no_handphone,
        'password': password,
        'no_rumah': _switchValue ? '$_valNoRumah $_valBlok' : '$_valPerusahaan',
        'status': _switchValue ? 'Penghuni Rumah' : 'Petugas',
      });

      final response = await dio.post(
          'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiAuthentication/register',
          data: formData
      );

      if(response.statusCode == 200){
        var data = json.decode(response.data);
        if(data['status_message'] == 'success'){
          Navigator.pushReplacementNamed(context, '/login');
        }else{
          setState(() {
            _showLoading = false;
            msg_error = data['message'];
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

  _pilihPerusahaan() {
    return Row(
      children: [
        DropdownButton(
          hint: const Text('Perusahaan'),
          value: _valPerusahaan,
          items: _listNamaPerusahaan.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _valPerusahaan = value.toString();
            });
          },
        )
      ],
    );
  }
}
