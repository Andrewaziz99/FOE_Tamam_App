abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class getLoginUserDataLoadingState extends LoginStates {}

class getLoginUserDataSuccessState extends LoginStates {}

class getLoginUserDataErrorState extends LoginStates {
  final String error;

  getLoginUserDataErrorState(this.error);
}

class RegisterLoadingState extends LoginStates {}

class RegisterSuccessState extends LoginStates {}

class RegisterErrorState extends LoginStates {
  final String error;

  RegisterErrorState(this.error);
}

class changePasswordLoadingState extends LoginStates {}

class changePasswordSuccessState extends LoginStates {}

class changePasswordErrorState extends LoginStates {}


