part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {}

class SessionAuthorized extends SessionState {}

class SessionUnauthorized extends SessionState {}

class SessionFailure extends SessionState {
  final message;
  const SessionFailure({this.message});
}
