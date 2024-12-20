import 'package:beunique_ecommerce/core/app_colors.dart';
import 'package:beunique_ecommerce/features/home_screen/provider/account_provider.dart';
import 'package:beunique_ecommerce/utils/font_class.dart';
import 'package:beunique_ecommerce/utils/responsive.dart';
import 'package:beunique_ecommerce/utils/utility_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Responsive.isMobile(context)
          ? const EdgeInsets.symmetric(horizontal: 15)
          : Responsive.isTablet(context)
              ? EdgeInsets.symmetric(
                  horizontal: Responsive.getSize(context).width * .15)
              : EdgeInsets.symmetric(
                  horizontal: Responsive.getSize(context).width * .25),
      width: double.infinity,
      child: Form(
        key: formKey,
        child: Consumer<AccountProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 38.0),
                child: Text(
                  "Account",
                  style: FontClass.extraLargeHeaderStyleBlackNormal,
                ),
              ),
              isSignUp
                  ? Column(
                      children: [
                        Container(
                          padding: UtilityClass.horizontalPadding,
                          alignment: Alignment.centerLeft,
                          child: const Text("Sign In"),
                        ),
                        Container(
                          padding: UtilityClass.horizontalAndVerticalPadding,
                          child: TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              final RegExp regex =
                                  RegExp(UtilityClass.emailPattern);
                              if (!regex.hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Email*"),
                          ),
                        ),
                        Container(
                          padding: UtilityClass.horizontalPadding,
                          child: TextFormField(
                            controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                                hintText: "Password*"),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: UtilityClass.horizontalAndVerticalPadding,
                          child: const Text("Lost your password?"),
                        ),
                        !provider.isSigningUser
                            ? Container(
                                width: Responsive.getSize(context).width,
                                height: 52,
                                margin: UtilityClass.horizontalPadding,
                                decoration: UtilityClass.setButtonDecoration(
                                    AppColors.darkColor),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context
                                            .read<AccountProvider>()
                                            .userSignIn(
                                                email.text, password.text);
                                      }
                                    },
                                    child: const Text("SIGN IN")),
                              )
                            : const CircularProgressIndicator()
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          padding: UtilityClass.horizontalPadding,
                          alignment: Alignment.centerLeft,
                          child: const Text("Sign Up"),
                        ),
                        Container(
                          padding: UtilityClass.horizontalAndVerticalPadding,
                          child: TextFormField(
                            controller: firstName,
                            validator: UtilityClass.firstNameValidator,
                            decoration:
                                const InputDecoration(hintText: "First Name"),
                          ),
                        ),
                        Container(
                          padding: UtilityClass.horizontalPadding,
                          child: TextFormField(
                            controller: lastName,
                            validator: UtilityClass.firstNameValidator,
                            decoration:
                                const InputDecoration(hintText: "Last Name"),
                          ),
                        ),
                        Container(
                          padding: UtilityClass.horizontalAndVerticalPadding,
                          child: TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              final RegExp regex =
                                  RegExp(UtilityClass.emailPattern);
                              if (!regex.hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Email*"),
                          ),
                        ),
                        Container(
                          padding: UtilityClass.horizontalPadding,
                          child: TextFormField(
                            controller: password,
                            validator: UtilityClass.passwordValidator,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                                hintText: "Password*"),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: UtilityClass.horizontalAndVerticalPadding,
                          child: Visibility(
                            visible: isSignUp,
                            child: const Text("Lost your password?"),
                          ),
                        ),
                        Container(
                          width: Responsive.getSize(context).width,
                          height: 55,
                          margin: UtilityClass.horizontalPadding,
                          decoration: UtilityClass.setButtonDecoration(
                              AppColors.darkColor),
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AccountProvider>().signUpUser(
                                      email.text,
                                      password.text,
                                      firstName.text,
                                      lastName.text);
                                }
                              },
                              child: const Text("SIGN UP")),
                        ),
                      ],
                    ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: UtilityClass.horizontalAndVerticalPadding,
                alignment: Alignment.centerLeft,
                child: Text(
                    isSignUp ? "New customer?" : "Already have an account?"),
              ),
              Visibility(
                visible: isSignUp,
                child: Container(
                  padding: UtilityClass.horizontalPadding,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                      "Sign up for early Sale access plus tailored new arrivals, trends and promotions. To opt out, click unsubscribe in our emails."),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 52,
                  margin: UtilityClass.horizontalAndVerticalPadding,
                  decoration:
                      UtilityClass.setButtonDecoration(AppColors.darkColor),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() => isSignUp = !isSignUp);
                      },
                      child: Text(!isSignUp ? "SIGN IN INSTEAD" : "REGISTER")),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
