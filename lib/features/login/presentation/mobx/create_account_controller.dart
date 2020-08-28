import 'package:mobx/mobx.dart';
import 'package:nutrients/features/login/domain/usecases/create_account_with_email.dart';
import 'package:meta/meta.dart';
import 'package:nutrients/features/login/domain/usecases/sign_in_with_google.dart';
part 'create_account_controller.g.dart';

class CreateAccountController = _CreateAccountControllerBase
    with _$CreateAccountController;

abstract class _CreateAccountControllerBase with Store {
  final CreateAccountWithEmail createAccountWithEmail;
  final SignInWithGoogle signInWithGoogle;

  _CreateAccountControllerBase({
    @required this.createAccountWithEmail,
    @required this.signInWithGoogle,
  });

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

  createAccount() async {
    setIsLoading(true);
    final response = await createAccountWithEmail.call(
      email: this.email,
      password: this.password,
    );
    setIsLoading(false);
    response.fold((failure) {
      setError(true);
      setErrorMessage(failure.message);
    }, (loggedUserData) {});
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
