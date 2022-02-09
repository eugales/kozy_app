import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kozy_app/blocs/authentication/authentication_bloc.dart';
import 'package:kozy_app/exceptions/authentication_exception.dart';
import 'package:kozy_app/repositories/authentication_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;

  SignUpBloc(AuthenticationBloc authenticationBloc, AuthenticationRepository authenticationRepository)
      : _authenticationBloc = authenticationBloc,
        _authenticationRepository = authenticationRepository,
        super(SignUpInitial()) {
    on<SignUpWithEmailButtonPressed>((event, emit) async {
      emit.call(SignUpLoading());
      try {
        final user = await _authenticationRepository.signUpWithEmailAndPassword(event.email, event.password);
        if (user != null) {
          _authenticationBloc.add(UserSignedUp(user: user));
          emit.call(SignUpSuccess());
          emit.call(SignUpInitial());
        } else {
          emit.call(const SignUpFailure(message: 'Wrong email or password'));
        }
      } on AuthenticationException catch (e) {
        emit.call(SignUpFailure(message: e.message));
      } catch (e) {
        emit.call(const SignUpFailure(message: 'An unknown error occured'));
      }
    });
  }
}
