import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kozy_app/repository/auth_repository.dart';
import 'package:kozy_app/repository/services/auth_service.dart';
import 'package:kozy_app/utils/token_preferences.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthRepository _authRepository = AuthRepository(service: AuthService());
  final TokenPreferences _tokenPreferences = TokenPreferences();

  SessionBloc() : super(SessionInitial()) {
    on<SessionValidate>((event, emit) async {
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

    on<SessionSignIn>((event, emit) async {
      try {
        final user = await _authRepository.signIn(event.email, event.password);
         emit(SessionAuthorized());
      } catch (e) {
        emit(SessionFailure(message: e.toString()));
      }
    });

    on<SessionSignOut>((event, emit) async {
      final token = await _tokenPreferences.getAuthToken();
      final result = await _authRepository.signOut(token);
      if (result) {
        emit(SessionUnauthorized());
      }
    });
  }
}
