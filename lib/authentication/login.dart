import 'package:cure_connect_service/pages/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscured = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Email & Password Login
  Future<UserCredential?> loginWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        Get.to(() => HomePage()); 
      }
      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Google Login
  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; // User cancelled the login
      }

      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(cred);

      if (userCredential.user != null) {
        Get.to(() => HomePage());
      }
      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.to(() => HomePage());
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Container(
                height: 360,
                child: Image.asset('assets/login page.png'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email field with validation
                    Container(
                      width: 400,
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == "") {
                            return 'Please enter Email';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF4A78FF)),
                          ),
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.mail_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password field with validation
                    Container(
                      width: 400,
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter the Password';
                          } else {
                            return null;
                          }
                        },
                        obscureText: _isObscured,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF4A78FF)),
                          ),
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          hintText: 'Enter Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            icon: Icon(_isObscured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          print('Form is valid. Proceed with Sign In');
                          loginWithEmailAndPassword();
                        } else {
                          print('Form is not valid');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A78FF),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 23),
                    Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 35,
                      child: Divider(
                        indent: 23,
                        endIndent: 23,
                      ),
                    ),

                    GestureDetector(
                      onTap: () async {
                        // Call Google login and wait for it to complete before navigating
                        await loginWithGoogle();
                      },
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Sign In with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
