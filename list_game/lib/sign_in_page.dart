import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../bloc/activeindexwebmenu/activeindexwebmenu_bloc.dart';
import '../theme.dart';
import 'custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Tidak benar!',
          ),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    Future<void> _submitfn() async {
      //if check email and password is empty
      if (_emailC.text.isEmpty || _passwordC.text.isEmpty) {
        _showErrorDialog('Please enter email and password');
        return;
      }
      setState(() {
        _isLoading = true;
      });

      // context.read<IsloadingloginBloc>().add(LoadingLoginStartEvent());

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailC.text, password: _passwordC.text);
        // context.read<IsloginBloc>().add(UserLoginEvent());
      } on FirebaseAuthException catch (e) {
        var errorMessage = 'Authentication failed';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage =
              'Kata sandi salah coba ingat-ingat lagi atau lupa password';
        }
        setState(() {
          _isLoading = false;
        });
        // context.read<IsloginBloc>().add(UserSignoutEvent());
        // ds.isLogin = false;
        _showErrorDialog(errorMessage);
      }
      // ds.isLoadingLogin = false;
      // context.read<IsloadingloginBloc>().add(LoadingLoginSelesaiEvent());
    }

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 24.0,
        right: 24.0,
      ),
      child: ListView(children: [
        const SizedBox(
          height: 60,
        ),
        Text(
          'Sign In',
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(height: 20),
        Text(
          'Welcome back',
          style: TextStyle(fontSize: 14, color: HexColor("#AAAAAA")),
        ),
        SizedBox(height: 40),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    nameTextField: 'Email',
                    iconTextField: Icon(
                      Icons.email_outlined,
                      size: 30,
                      color: HexColor('#889098'),
                    ),
                    controller: _emailC,
                  ),
                  CustomTextField(
                    nameTextField: 'Password',
                    iconTextField: Icon(
                      Icons.lock_outline,
                      size: 30,
                      color: HexColor('#889098'),
                    ),
                    controller: _passwordC,
                    isPassword: true,
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () {
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //     builder: (context) => const ForgotPassword(),
            //       //   ),
            //       // );
            //     },
            //     child: Text(
            //       'Lupa password ?',
            //       style: kGreyTextStyle.copyWith(
            //         fontWeight: regular,
            //         fontSize: 16,
            //         color: Colors.black,
            //       ),
            //     ),
            //   ),
            // ),

            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor("#324A59"),
              ),
              child: TextButton(
                  onPressed: _submitfn,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      : Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        )),
            ),
            const SizedBox(
              height: 20.0,
            ),

            Row(
              children: [
                TextButton(
                    onPressed: () => context.read<ActiveindexwebmenuBloc>().add(
                        ChangeactiveindexwebmenuEvent(activeindex: 'Register')),
                    // () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const SignUpPage(),
                    //   ),
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New member?',
                          style: kGreyTextStyle.copyWith(
                              fontWeight: light, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Sign Up',
                          style: kGreyTextStyle.copyWith(
                              fontWeight: regular, color: Colors.blue),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
        // const ContactUs()
      ]),
    ));
  }
}
