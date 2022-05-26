import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool formState;
  final void Function(
    String email,
    String password,
    String username,
    bool loginState,
    BuildContext ctx,
  ) formFnc;

  const AuthForm({
    Key? key,
    required this.formState,
    required this.formFnc,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _loginState = true;
  String email = '';
  String password = '';
  String username = '';

  void _submitForm() {
    final validForm = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validForm) {
      _formKey.currentState!.save();
      widget.formFnc(
        email.trim(),
        password.trim(),
        username.trim(),
        _loginState,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (val) {
                      if (val!.isEmpty || !val.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (savedVal) {
                      email = savedVal!;
                    },
                  ),
                  if (!_loginState)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 4) {
                          return 'Username must be at least four characters long';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (savedVal) {
                        username = savedVal!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 7) {
                        return 'Password must be seven characters long';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (savedVal) {
                      password = savedVal!;
                    },
                  ),
                  const SizedBox(height: 15),
                  if (widget.formState)
                    const CircularProgressIndicator(),
                  if(!widget.formState)
                  RaisedButton(
                    onPressed: _submitForm,
                    child: Text(
                      _loginState ? 'Login' : 'SignUp',
                    ),
                  ),
                  if(!widget.formState)
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _loginState = !_loginState;
                      });
                    },
                    child: Text(
                      _loginState
                          ? 'Create new account'
                          : 'Already have an account',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
