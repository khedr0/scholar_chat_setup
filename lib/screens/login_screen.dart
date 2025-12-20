import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_setup_main/screens/register_screen.dart';

import '../constants/colors.dart';
import '../helper/snackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? emailAddress;

  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                ),
                Image(
                  image: AssetImage("assets/images/scholar.png"),
                  height: 100,
                ),
                Center(
                  child: Text(
                    "Scholar Chat",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: "Pacifico",
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  onChanged: (value) {
                    emailAddress = value;
                  },
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    hintText: "Password",
                    onChanged: (value) {
                      password = value;
                    }),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  text: "Login",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await loginservices();
                        Navigator.pushNamed(context, ChatScreen.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ShowSnackBar(
                              context: context,
                              message: 'wrong email or password',
                              isSucces: false);
                        } else if (e.code == 'wrong-password') {
                          ShowSnackBar(
                            context: context,
                            message: 'wrong email or password',
                            isSucces: false,
                          );
                        } else {
                          ShowSnackBar(
                            context: context,
                            message: 'wrong email or password',
                            isSucces: false,
                          );
                        }
                      } catch (e) {
                        ShowSnackBar(
                          context: context,
                          message:
                              'Something went wrong. Please try again later.',
                          isSucces: false,
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        " Register",
                        style:
                            TextStyle(color: Color(0xffC7EDE6), fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginservices() async {
    final credintial = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );
  }
}
