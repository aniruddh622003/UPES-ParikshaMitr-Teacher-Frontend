import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/custom_text_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/password_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double minHeight = screenHeight - appBarHeight - statusBarHeight;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          'UPES Pariksha Mitr - Teachers',
          style: TextStyle(
            fontSize: fontMedium,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        backgroundColor: blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 17, 0),
                      child: Text(
                        "Welcome Back.",
                        style: TextStyle(
                          fontSize: fontXLarge,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 6, 16, 10),
                      child: Text(
                        "We are happy to assist you again.",
                        style: TextStyle(
                          color: grayDark,
                          fontSize: fontMedium,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 90),
                      child: SvgPicture.asset('android/assets/signinpage.svg'),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: CustomTextField(label: 'Enter your sap ID'),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: PasswordField(label: 'Enter your password'),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(214, 0, 29, 0),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: orange, fontSize: fontSmall),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size(310, 40),
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                color: white,
                                fontSize: fontMedium,
                                fontWeight: FontWeight.w800),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(310, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: orange,
                              width: 1.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogInPage()));
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: black,
                              fontSize: fontSmall,
                            ),
                            children: [
                              TextSpan(text: 'Don\'t have an account? '),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                    color: orange, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
