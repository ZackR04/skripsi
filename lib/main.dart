import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/authentication/presentation/ui/login_screen.dart';
import 'package:skripsi_residencereport/feature/home/presentation/ui/home_screen.dart';
import 'package:skripsi_residencereport/feature/splash/presentation/bloc/splash_bloc.dart';
import 'package:skripsi_residencereport/feature/splash/presentation/ui/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (_) => SplashBloc(),
          child: SplashScreen(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/login': (context) => HomeScreen(),
          // '/home': (context) => ,
        },
      ),
    );
  }
}

