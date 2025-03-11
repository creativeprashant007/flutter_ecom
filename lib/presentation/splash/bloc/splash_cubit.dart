import 'package:ecommerce/presentation/splash/bloc/splash_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(Duration(seconds: 2));
    emit(UnAuthenticated());
  }
}
