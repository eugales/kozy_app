part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UserSignedIn extends AuthenticationEvent {
  final User user;

  const UserSignedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class UserSignedUp extends AuthenticationEvent {
  final User user;

  const UserSignedUp({required this.user});

  @override
  List<Object> get props => [user];
}

class UserSignedOut extends AuthenticationEvent {}
