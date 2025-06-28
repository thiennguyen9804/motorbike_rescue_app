import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mmkv/mmkv.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/firebase_options.dart';
import 'package:motorbike_rescue_app/presentation/auth/auth_wrapper.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/instruction_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/home_wrapper.dart';
import 'package:motorbike_rescue_app/presentation/main/main_router.dart';
import 'package:motorbike_rescue_app/sl.dart';

void main() async {
  final rootDir = await MMKV.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final token = await _messaging.getToken();
  FirebaseMessaging.onMessage.listen((message) {
    print('Foreground FCM: ${message.notification?.title}');
  });

  // Background > Foreground (app đang mở từ thông báo)
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('FCM opened from background: ${message.notification?.title}');
  });
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
    ),
  );

  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motorbike Rescue',
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', ''),
      ],
      home: BlocProvider(
        create: (context) => InstructionCubit(),
        child: MainRouter(),
      ),
    );
  }
}
