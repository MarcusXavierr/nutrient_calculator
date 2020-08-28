import 'package:mobx/mobx.dart';
import 'package:nutrients/features/login/domain/usecases/login_with_email.dart';
import 'package:nutrients/features/login/domain/usecases/sign_in_with_google.dart';
import 'package:meta/meta.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final LoginWithEmail loginWithEmail;
  final SignInWithGoogle signInWithGoogle;

  _LoginControllerBase(
      {@required this.loginWithEmail, @required this.signInWithGoogle});

  @observable
  String email = '';

  @action
  setEmail(String value) => this.email = value;

  @observable
  String password = '';

  @action
  setPassword(String value) => this.password = value;

  @observable
  bool isLoading = false;

  @action
  setIsLoading(bool value) => this.isLoading = value;

  @observable
  bool error = false;

  @action
  setError(bool value) => this.error = value;

  @observable
  String errorMessage;

  @action
  setErrorMessage(String value) => this.errorMessage = value;

  authenticateWithEmail() async {
    print('Entrei no metodo $email e $password');
    setIsLoading(true);
    final result = await loginWithEmail.call(
      email: this.email,
      password: this.password,
    );
    setIsLoading(false);

    result.fold((failure) {
      setErrorMessage(failure.message);
      setError(true);
    }, (loggedUserData) {
      print('Deu bom');
    });
  }

  authenticaWithGoogle() async {
    setIsLoading(true);
    final result = await signInWithGoogle.call();
    setIsLoading(false);
    result.fold((failure) {
      setError(true);
      setErrorMessage(failure.message);
    }, (loggedUserData) {});
  }
}
