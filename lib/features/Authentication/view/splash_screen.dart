import 'package:flutter/material.dart';
import '../../../core/constants/asset_constants.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  /// navigate login screen
  navigateLoginScreen(){
Future.delayed(const Duration(seconds: 2),(){
return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),),(route) => false,);
});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
navigateLoginScreen();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(AssetConstants.splash),
        ),
      ),
    );
  }
}
