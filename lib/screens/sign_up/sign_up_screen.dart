import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/form_title_and_field.dart';
import '../sign_in/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? username;
  String? email;
  String? password;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: username!, password: password!);
      return "Yes";
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return "No";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: formKey,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            color: Colors.white,
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 600,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Sign Up",
                          style: largestText,
                        ),
                        const SizedBox(height: 50),
                        FormTitleAndField(
                          title: "Username",
                          textEditingController: usernameController,
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        FormTitleAndField(
                          title: "Email",
                          textEditingController: emailController,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        FormTitleAndField(
                          title: "Password",
                          textEditingController: passwordController,
                          obscure: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        CustomTextButton(
                            text: "Sign Up",
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                print(username);
                                print(email);
                                print(password);

                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                    email: email!,
                                    password: password!)
                                    .then((currentUser) => FirebaseFirestore.instance.collection('users').doc(
                                    currentUser.user!.uid)
                                    .set({
                                  "uid": currentUser.user!.uid,
                                  "created":DateTime.now().toLocal().toString(),
                                  "name": username,
                                  "email":  email,
                                  "password":password,
                                }).then((value){

                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SignInScreen();
                                    },
                                  ));
                                }));

                                // await authService.signUp(
                                //   username: username!,
                                //   email: email!,
                                //   password: password!,
                                // );

                              } else {
                                print("not good");
                              }
                            }),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account ? "),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return SignInScreen();
                                  },
                                ));
                              },
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.montserrat(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
