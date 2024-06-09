import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_game/home.dart';

import '../bloc/datauser/datauser_bloc.dart';
import 'bloc/activeindexwebmenu/activeindexwebmenu_bloc.dart';
import 'error_page.dart';
import 'loading.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'theme.dart';

class StreamAuth extends StatefulWidget {
  const StreamAuth({
    Key? key,
  }) : super(key: key);

  @override
  State<StreamAuth> createState() => _StreamAuthState();
}

class _StreamAuthState extends State<StreamAuth> {
  @override
  Widget build(BuildContext context) {
    // final dp = Provider.of<DataProvider>(context);
    String activeindexwebmenu = context.select<ActiveindexwebmenuBloc, String>(
        (value) => value.state.activeindexwebmenu);

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          }
          if (userSnapshot.hasData) {
            // return const TabbarComponent();
            final user = FirebaseAuth.instance.currentUser;

            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const ErrorPage();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(child: Loading()));
                }
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                if (snapshot.hasData && snapshot.data?.data() != null) {
                  // print('data nya' + data['username'].toString());

                  context.read<DatauserBloc>().add(DatauserEventFetch(
                        disukai: data['disukai'] ?? [],
                      ));

                  return Home();
                }

                return CircularProgressIndicator();
              },
            );
          }

          return activeindexwebmenu == 'Login'
              ? AnimatedContainer(
                  duration: kDefaultDuration, child: const SignInPage())
              : AnimatedContainer(
                  duration: kDefaultDuration, child: const SignUpPage());

          // return const Login();
        });
  }
}
