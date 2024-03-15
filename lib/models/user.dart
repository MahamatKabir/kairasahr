class User {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;

  User({this.name, this.email, this.phoneNumber, this.password});
}

class SignInPayload {
  final String? email;
  final String? password;

  SignInPayload({this.email, this.password});
}

class SignUpPayload {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;

  SignUpPayload({this.name, this.email, this.phoneNumber, this.password});
}
