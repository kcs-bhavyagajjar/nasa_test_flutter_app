import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/api_repository.dart';
import 'package:test_app/apistate.dart';

class LoginCubit extends Cubit<ApiState> {
  final ApiRepository repository;

  LoginCubit(this.repository) : super(ApiInitial());

  Future<void> getTotalCredits() async {
    emit(ApiLoading());
    try {
      final mList = await repository.getAll();
      emit(ApiLoaded(mList));
    } catch (e) {
      emit(ApiError("Failed to fetch data. is your device online?"));
    }
  }
}
