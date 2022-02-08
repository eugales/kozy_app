import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kozy_app/blocs/authentication/authentication_bloc.dart';
import 'package:kozy_app/exceptions/authentication_exception.dart';
import 'package:kozy_app/repositories/authentication_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;

  SignInBloc(AuthenticationBloc authenticationBloc, AuthenticationRepository authenticationRepository)
      : _authenticationBloc = authenticationBloc,
        _authenticationRepository = authenticationRepository,
        super(SignInInitial()) {
    on<SignInWithEmailButtonPressed>((event, emit) async {
      emit.call(SignInLoading());
      try {
        final user = await _authenticationRepository.signInWithEmailAndPassword(event.email, event.password);
        if (user != null) {
          _authenticationBloc.add(UserSignedIn(user: user));
          emit.call(SignInSuccess());
          emit.call(SignInInitial());
        } else {
          emit.call(const SignInFailure(message: 'Wrong email or password'));
        }
      } on AuthenticationException catch (e) {
        emit.call(SignInFailure(message: e.message));
      } catch (e) {
        emit.call(const SignInFailure(message: 'An unknown error occured'));
      }
    });
  }
}
