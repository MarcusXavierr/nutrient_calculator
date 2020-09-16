import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/features/login/presentation/mobx/login_controller.dart';
import 'package:nutrients/features/login/presentation/pages/components/error_alert_widget.dart';
import 'package:nutrients/features/login/presentation/pages/create_account/create_account_page.dart';

class LoginPage extends StatelessWidget {
  final _controller = GetIt.I.get<LoginController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) => _controller.setEmail(value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type your email',
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill in the field";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: kSizedBoxHeight,
                    ),
                    TextFormField(
                      onSaved: (value) => _controller.setPassword(value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type your password',
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill in the field";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Observer(
                      builder: (_) {
                        if (_controller.isLoading) {
                          return CircularProgressIndicator();
                        } else {
                          return Column(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();

                                    await _controller.authenticateWithEmail();
                                    // ! Use Asuka to show a snackbar later
                                    if (!_controller.error) {
                                      _controller.setError(false);
                                      return null;
                                    }

                                    if (_controller.error) {
                                      return errorAlertWidget(
                                        _controller.errorMessage,
                                        context,
                                      ).show();
                                    }
                                  }
                                },
                                child: Text('Login'),
                                textColor: Colors.white,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              SignInButton(
                                Buttons.Google,
                                onPressed: () async {
                                  await _controller.authenticaWithGoogle();
                                },
                                text: 'Sign in with Google',
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAccount(),
                          ),
                        );
                      },
                      child: Text('Don\'t have an account? Register here'),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
