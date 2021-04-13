part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.message,
    
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? message;
  
  @override
  List<Object> get props => [email, password, status];

  SignUpState copyWith({
    UserName? userName,
    NumberPhone? phone,
    Email? email,
    Password? password,
    FormzStatus? status,
    String? message,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
