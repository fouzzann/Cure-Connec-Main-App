
import 'package:cure_connect_service/screens/home_page/home_page.dart';
import 'package:cure_connect_service/welcome%20page/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if(_auth.currentUser!=null){
        Get.offAll(()=>HomePage());
      }
     else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> WelcomePage()));
     }
  
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/app_logo-removebg-preview.png')),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 480),
                child: Text(
                  'Cure Connect',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 117, 117, 117)),
                ),
              ),
              SizedBox(
                height: 235,
              ),
              CircularProgressIndicator(
                color: const Color.fromARGB(255, 10, 134, 122),
              )
            ],
          ),
        ),
      ),
    );
  }
}
