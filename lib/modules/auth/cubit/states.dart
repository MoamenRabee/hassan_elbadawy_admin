abstract class AuthStates{}

class AuthInitState extends AuthStates{}

class AuthLogInLoadingState extends AuthStates{}
class AuthLogInSuccessState extends AuthStates{}
class AuthLogInErrorState extends AuthStates{
  String err;
  AuthLogInErrorState(this.err);
}