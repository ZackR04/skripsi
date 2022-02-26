part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {
}

class InitialSplashEvent extends SplashEvent {}

class SetSplashEvent extends SplashEvent {}
