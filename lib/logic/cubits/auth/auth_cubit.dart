import 'package:bloc/bloc.dart';
import 'package:deu_api/deu_api.dart' show AuthApi, AuthenticationException;
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationType {
  auto,
  normal,
}

enum AuthenticationError {
  wrongpassword,
  connectionerror,
  none,
}

enum AuthenticationStatus {
  unknown,
  authenticating,
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  const AuthenticationState(
      {this.status = AuthenticationStatus.unknown,
      this.error = AuthenticationError.none,
      this.username = '',
      this.password = ''});

  const AuthenticationState.authenticating()
      : this(
            status: AuthenticationStatus.authenticating,
            error: AuthenticationError.none);
  const AuthenticationState.unauthenticated(
      AuthenticationError error, String username, String password)
      : this(
            status: AuthenticationStatus.unauthenticated,
            error: error,
            username: username,
            password: password);
  const AuthenticationState.authenticated()
      : this(
            status: AuthenticationStatus.authenticated,
            error: AuthenticationError.none);

  final AuthenticationStatus status;
  final AuthenticationError error;
  final String username, password;

  @override
  List<Object> get props => [status];
}

class AuthCubit extends Cubit<AuthenticationState> {
  AuthCubit(this.authApi, this.sharedPreferences)
      : super(const AuthenticationState());

  final AuthApi authApi;
  final SharedPreferences sharedPreferences;

  Future autoLogin() async {
    final username = sharedPreferences.getString('username');
    final password = sharedPreferences.getString('password');
    if (username != null && password != null) {
      await login(username, password, AuthenticationType.auto);
    }
  }

  Future saveCredentials(String username, String password) async {
    await sharedPreferences.setString('username', username);
    await sharedPreferences.setString('password', password);
  }

  Future logout() async {
    await sharedPreferences.clear();
  }

  Future login(String username, String password,
      [AuthenticationType type = AuthenticationType.normal]) async {
    emit(const AuthenticationState.authenticating());
    try {
      await authApi
          .login(username.replaceAll('@ogr.deu.edu.tr', ''), password)
          .timeout(const Duration(seconds: 10));
      await saveCredentials(username, password);
      emit(const AuthenticationState.authenticated());
    } on AuthenticationException {
      emit(AuthenticationState.unauthenticated(
          AuthenticationError.wrongpassword, username, password));
    } catch (e) {
      emit(AuthenticationState.unauthenticated(
          AuthenticationError.connectionerror, username, password));
    }
  }
}
