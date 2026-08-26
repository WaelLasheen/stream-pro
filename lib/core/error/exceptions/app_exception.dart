import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;
  const AppException([this.message = 'App Exception']);
  
}
