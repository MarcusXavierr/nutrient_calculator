import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/components/form_button.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/features/login/presentation/mobx/create_account_controller.dart';
import 'package:nutrients/features/login/presentation/pages/components/error_alert_widget.dart';
import 'package:nutrients/features/login/presentation/pages/login/login_page.dart';
import 'package:nutrients/injection_container.dart';

class CreateAccount extends StatelessWidget {
  final _controller = GetIt.I.get<CreateAccountController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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

                                    await _controller.createAccount();

                                    if (_controller.error) {
                                      return errorAlertWidget(
                                        _controller.errorMessage,
                                        context,
                                      ).show();
                                    }
                                  }
                                },
                                child: Text('Register'),
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
                                  Navigator.pop(context);
                                },
                                text: 'Sign up with Google',
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
                        Navigator.pop(context);
                      },
                      child: Text('Already have an account? Log in here'),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
