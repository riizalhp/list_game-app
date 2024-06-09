import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../bloc/activeindexwebmenu/activeindexwebmenu_bloc.dart';
import '../theme.dart';
import 'custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();
  // final TextEditingController _hobbyCtl = TextEditingController();
  // final TextEditingController _fotoCtl = TextEditingController();

  String? fotopath;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtl.dispose();
    _emailCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> _registerPengguna() async {
      // context.read<IsloadingloginBloc>().add(LoadingLoginStartEvent());
      if (_nameCtl.text.isEmpty ||
          _emailCtl.text.isEmpty ||
          _passwordCtl.text.isEmpty) {
        // context.read<IsloadingloginBloc>().add(LoadingLoginSelesaiEvent());

        //if not show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Pengguna belum lengkap '),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          _isLoading = true;
        });
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailCtl.text, password: _passwordCtl.text);
          final uid = userCredential.user?.uid;

          return users.doc(uid).set({
            "id": uid,
            'name': _nameCtl.text,
            'email': _emailCtl.text,
            'password': _passwordCtl.text,
            'disukai': [],
          }).then((value) {
            setState(() {
              _isLoading = false;
            });
            //show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Register berhasil'),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
            // Navigator.pop(context);
          });
          // .then((value) => print("User Added"))
          // .catchError((error) => print("Failed to add user: $error"));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            // print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            // print('The account already exists for that email.');
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                // backgroundColor: bluedefault(),
                title: const Text('Email already in use'),
                content:
                    const Text('The account already exists for that email.'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                // backgroundColor: bluedefault(),
                title: const Text('Email cannot use'),
                content: const Text('The email cannot use.'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
            );
          }
        } catch (e) {
          //showdialog error
          // context.read<IsloadingloginBloc>().add(LoadingLoginSelesaiEvent());
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 24.0,
          right: 24.0,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              'Create an account here',
              style: TextStyle(fontSize: 14, color: HexColor("#AAAAAA")),
            ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CustomTextField(
                        nameTextField: 'Your Name',
                        iconTextField: Icon(
                          Icons.person,
                          color: HexColor('#889098'),
                          size: 30,
                        ),
                        controller: _nameCtl,
                      ),
                      CustomTextField(
                        nameTextField: 'Email',
                        iconTextField: Icon(
                          Icons.email,
                          size: 30,
                          color: HexColor('#889098'),
                        ),
                        controller: _emailCtl,
                      ),
                      CustomTextField(
                        nameTextField: 'Password',
                        iconTextField: Icon(
                          Icons.lock,
                          size: 30,
                          color: HexColor('#889098'),
                        ),
                        controller: _passwordCtl,
                        isPassword: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: TextButton(
                  onPressed: _registerPengguna,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        )),
            ),
            SizedBox(height: 80),
            Row(
              children: [
                TextButton(
                    onPressed: () => context.read<ActiveindexwebmenuBloc>().add(
                        ChangeactiveindexwebmenuEvent(activeindex: 'Login')),
                    //pop
                    // () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: kGreyTextStyle.copyWith(
                              fontWeight: light, color: Colors.black),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign In',
                          style: kGreyTextStyle.copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: regular,
                              color: Colors.blue),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
