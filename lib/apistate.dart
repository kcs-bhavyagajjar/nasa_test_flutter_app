import 'package:test_app/Model/imagemodel.dart';

abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final List<Item> responseModel;

  ApiLoaded(this.responseModel);
}

class ApiError extends ApiState {
  final String? message;

  ApiError(this.message);
}
