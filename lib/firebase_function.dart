


sealed class AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String uid;
  AuthSuccess(this.uid);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
