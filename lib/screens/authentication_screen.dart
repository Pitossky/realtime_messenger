import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:realtime_messenger/widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _userAuth = FirebaseAuth.instance;
  bool _loadState = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool loginState,
    BuildContext ctx,
  ) async {
    UserCredential userAuthResult;

    try {
      setState(() {
        _loadState = true;
      });
      if (loginState) {
        userAuthResult = await _userAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userAuthResult = await _userAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(
              userAuthResult.user!.uid,
            )
            .set({
          'username': username,
          'email': email,
        });
      }
    } on PlatformException catch (err) {
      var message = 'Please check credentials';
      if (err.message != null) {
        message = err.message.toString();
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _loadState = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _loadState = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        formFnc: _submitAuthForm,
        formState: _loadState,
      ),
    );
  }
}
