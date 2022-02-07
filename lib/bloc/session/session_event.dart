part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class SessionValidate extends SessionEvent {}
class SessionSignIn extends SessionEvent {
  final String email;
  final String password;

  const SessionSignIn({required this.email, required this.password});
}
class SessionSignUp extends SessionEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String roleName;

  const SessionSignUp(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.roleName});
}
class SessionSignOut extends SessionEvent {}
