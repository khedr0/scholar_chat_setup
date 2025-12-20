import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants/colors.dart';
import '../helper/snackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "RegisterScreen";
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? emailAddress;
  bool isLoding = false;
  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
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
                      "Register",
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
                  text: "Register",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoding = true;
                      });
                      try {
                        await userRegistration();
                        ShowSnackBar(
                          context: context,
                          message: 'Successfully Registered',
                          isSucces: true,
                        );
                        Navigator.pushNamed(context, ChatScreen.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ShowSnackBar(
                              context: context,
                              message: 'The password provided is too weak.',
                              isSucces: false);
                        } else if (e.code == 'email-already-in-use') {
                          ShowSnackBar(
                            context: context,
                            message:
                                'The account already exists for that email.',
                            isSucces: false,
                          );
                        } else {
                          // Firebase error غير متوقع
                          ShowSnackBar(
                            context: context,
                            message: '${e.message}',
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
                        isLoding = false;
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
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        " Login",
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

  Future<void> userRegistration() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );
  }
}
