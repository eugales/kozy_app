import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kozy_app/exceptions/authentication_exception.dart';
import 'package:kozy_app/models/models.dart';
import 'package:kozy_app/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _repository;

  AuthenticationBloc(AuthenticationRepository repository)
      : _repository = repository,
        super(AuthenticationInitial()) {
    on<AppLoaded>((event, emit) async {
      emit.call(AuthenticationLoading());
      try {
        final user = await _repository.getCurrentUser();
        if (user != null) {
          emit.call(AuthenticationAuthenticated(user: user));
        } else {
          emit.call(AuthenticationNotAuthenticatied());
        }
      } on AuthenticationException catch (e) {
        emit.call(AuthenticationFailure(message: e.message));
      }
    });

    on<UserSignedIn>((event, emit) {
      emit.call(AuthenticationAuthenticated(user: event.user));
    });

    on<UserSignedUp>((event, emit) {
      emit.call(AuthenticationAuthenticated(user: event.user));
    });

    on<UserSignedOut>((event, emit) async {
      if(await _repository.signOut()) emit.call(AuthenticationNotAuthenticatied());
    });
  }
}
