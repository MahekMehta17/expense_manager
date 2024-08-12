import 'package:expense_manager/custom_widgets/custom_text_form.dart';
import 'package:expense_manager/pages/signup_pages.dart';
import 'package:expense_manager/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// import '../firebase/auth_method.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _userPassController.dispose();
  }

  String? _userEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your EmailAddress';
    }
    return null;
  }

  String? _userPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return "Please Enter your Password";
    }

    // if (!RegExp(
    //     r"^(?=.*?[A-Z])(?=.*?[+a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$")
    //     .hasMatch(value)) {
    //   return "Please Enter valid Password";
    // }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.green),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 40, left: 40),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomTextField(
                          validator: _userEmailValidator,
                          controller: _userController,
                          prefixIcon: Icons.email,
                          hintText: "Enter Email",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomTextField(
                          validator: _userPasswordValidator,
                          controller: _userPassController,
                          obscureText: true,
                          prefixIcon: Icons.lock,
                          hintText: "Enter Your Password",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: 46,
                  width: 330,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      // shape: BoxShape.circle,
                      color: Colors.green),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_loginKey.currentState!.validate()) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(email: _userController.text.trim(), password: _userPassController.text.trim())
                              .then((value) {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
                            Navigator.of(context)
                                .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false);
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(const SnackBar(content: Text("User doesn't exist")));
                            print("Error${error.toString()}");
                          });
                        }

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 60, right: 60),
                child: FittedBox(
                    child: RichText(
                        text: TextSpan(style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.blueGrey), children: [
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            )),
                      text: "SignUp",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.green))
                ]))),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
