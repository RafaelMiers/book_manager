import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/utils/use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final SignOutUseCase _signOut;
  final AuthRepository _repository;

  AuthBloc({
    required SignInUseCase signIn,
    required SignUpUseCase signUp,
    required SignOutUseCase signOut,
    required AuthRepository repository,
  })  : _signIn = signIn,
        _signUp = signUp,
        _signOut = signOut,
        _repository = repository,
        super(const AuthInitial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.getCurrentUser();
    result.fold(
      (_) => emit(const AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signIn(
      SignInParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (data) => emit(AuthAuthenticated(data.$1)),
    );
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signUp(
      SignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (data) => emit(AuthAuthenticated(data.$1)),
    );
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _signOut(const NoParams());
    emit(const AuthUnauthenticated());
  }
}
