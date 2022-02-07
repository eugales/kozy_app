import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:kozy_app/repository/auth_repository.dart';
import 'package:kozy_app/repository/models/errors/auth_error.dart';
import 'package:kozy_app/repository/models/user.dart';
import 'package:kozy_app/repository/services/auth_service.dart';
import 'package:kozy_app/utils/token_preferences.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthRepository _authRepository = AuthRepository(service: AuthService());
  final TokenPreferences _tokenPreferences = TokenPreferences();

  SessionBloc() : super(SessionInitial()) {
    on<SessionSignUp>((event, emit) async {
      emit(SessionInprogress());
      try {
        final userMap = User.mapForAuth(event.email, event.password,
            event.firstName, event.lastName, event.roleName);
        final user = await _authRepository.signUp(userMap);
        emit(SessionRegistered());
      } on ErrorRegistration catch (e) {
        emit(SessionFailure(message: e.message));
      } catch (e) {
        emit(SessionFailure(message: e.toString()));
      }
    });

    on<SessionSignIn>((event, emit) async {
      emit(SessionInprogress());
      try {
        final user = await _authRepository.signIn(event.email, event.password);
        emit(SessionAuthorized());
      } catch (e) {
        emit(SessionFailure(message: e));
      }
    });

    on<SessionSignOut>((event, emit) async {
      emit(SessionInprogress());
      final token = await _tokenPreferences.getAuthToken();
      final result = await _authRepository.signOut(token);
      emit(SessionUnauthorized());
    });

    on<SessionValidate>((event, emit) async {
      emit(SessionInprogress());
      final haveToken = await _tokenPreferences.haveAuthToken();
      if (haveToken) {
        final valid = await _authRepository.validateAuthToken();
        if (valid) {
          emit(SessionAuthorized());
        } else {
          emit(SessionUnauthorized());
        }
      } else {
        emit(SessionUnauthorized());
      }
    });
  }
}
