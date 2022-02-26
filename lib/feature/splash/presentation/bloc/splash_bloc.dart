import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SetSplashEvent>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(Duration(seconds: 5));
      emit(SplashLoaded());
    });
  }
}
