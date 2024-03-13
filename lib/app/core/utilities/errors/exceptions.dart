import 'dart:io';

import 'package:equatable/equatable.dart';

import 'failure.dart';

// Remote Datasource Exceptions
class ServerException extends Equatable implements Exception {
  final Failure failure;
  const ServerException(this.failure);
  @override
  List<Object?> get props => [failure];
}

class NetworkException extends Equatable implements IOException {
  final Failure failure;
  const NetworkException(this.failure);
  @override
  List<Object?> get props => [failure];
}

// Local Datasource Exceptions
class CacheException extends Equatable implements Exception {
  final Failure failure;
  const CacheException(this.failure);
  @override
  List<Object?> get props => [failure];
}

class HiveException extends Equatable implements Exception {
  final Failure failure;
  const HiveException(this.failure);
  @override
  List<Object?> get props => [failure];
}

// Misc Exceptions
class UnexpectedException extends Equatable implements Exception {
  final Failure failure;
  const UnexpectedException(this.failure);
  @override
  List<Object?> get props => [failure];
}
