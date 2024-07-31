import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/core/api/api_consumer.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState>{
  MainCubit(this.api) : super(MainInitState());

  final ApiConsumer api;

  signIn({
    required String email,
    required String password,
}) async {

  }
}