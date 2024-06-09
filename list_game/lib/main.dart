import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/Islogin/islogin_bloc.dart';
import 'bloc/activeindexwebmenu/activeindexwebmenu_bloc.dart';
import 'bloc/datauser/datauser_bloc.dart';
import 'bloc/isloadinglogin/isloadinglogin_bloc.dart';
import 'state_util.dart';
import 'stream_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //memastikan binding widget sudah di inisialisasi
  await Firebase.initializeApp(); //inisialisasi firebase
  runApp(const MyApp()); //menjalankan aplikasi utama
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState(); //membuat state untuk myapp
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IsloadingloginBloc(), //BLoC untuk state loading saat login
        ),
        BlocProvider(
          create: (context) => IsloginBloc(), //BLoC untuk state login
        ),
        BlocProvider(
          create: (context) => DatauserBloc(), //BLoc untuk state data user
        ),
        BlocProvider(
          create: (context) => ActiveindexwebmenuBloc(), //BLoC untuk state active index menu
        ),
      ],
      child: MaterialApp(
          navigatorKey: Get.navigatorKey,
          color: Colors.blue,
          debugShowCheckedModeBanner: false,
          title: 'List Game',
          theme: ThemeData.light().copyWith(
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.blue,
            ),
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black),
            canvasColor: Colors.blue.shade700,
          ),
          home: StreamAuth()), //menampilkan halaman utama StreamAuth
    );
  }
}
