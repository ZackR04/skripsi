import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skripsi_residencereport/feature/splash/presentation/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    context.read<SplashBloc>().add(SetSplashEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
        listener: (context, state){
          if(state is SplashInitial){
            print("INITIAL");
          }
          else if(state is SplashLoading){
            print("LOADING");
          }
          else if(state is SplashLoaded){
            print("LOADED");
            Navigator.pushNamed(context, '/login');
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png'),
                LinearProgressIndicator(),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text("Residence Report", style: TextStyle(fontSize: 15,)),
              ],
            ),
          ),
        ),
    );
  }
}
