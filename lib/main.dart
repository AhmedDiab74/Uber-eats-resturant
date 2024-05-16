import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturant/controller/provider/mobile_auth_provider/mobile_auth_provider.dart';
import 'package:ubereatsresturant/firebase_options.dart';
import 'package:ubereatsresturant/view/auth_screen/mobile_login_screen.dart';
import 'package:ubereatsresturant/view/auth_screen/otp_screen.dart';
import 'package:ubereatsresturant/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ubereatsresturant/view/resturant_registration_screen/resturant_registration_screen.dart';
import 'package:ubereatsresturant/view/sign_in_logic_screen/sign_in_logic_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, __) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider<MobileAuthProvider>(
                create: (_) => MobileAuthProvider(),
              ),
            ],
            child: const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: ResturantRegistrationScreen()));
      },
    );
  }
}
