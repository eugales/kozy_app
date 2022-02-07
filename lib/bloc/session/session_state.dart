part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {}
class SessionInprogress extends SessionState {}
class SessionRegistered extends SessionState {}
class SessionAuthorized extends SessionState {}
class SessionUnauthorized extends SessionState {}
class SessionFailure extends SessionState {
  final message;
  SessionFailure({this.message}) {
    if (kDebugMode) {
      print(message.toString());
    }
  }
}


