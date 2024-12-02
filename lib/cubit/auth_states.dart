class AuthStates {}

class SuccessState extends AuthStates {}

class FailedState extends AuthStates {
  String errorMsg;
  FailedState({required this.errorMsg});
}
