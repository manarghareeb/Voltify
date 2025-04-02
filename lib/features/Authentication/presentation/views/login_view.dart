import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:voltify/features/Authentication/cubit/auth_cubit.dart';
import 'package:voltify/features/Authentication/presentation/views/registeration_screen.dart';
import 'package:voltify/features/Authentication/presentation/widgets/already_have_account.dart';
import 'package:voltify/features/Authentication/presentation/widgets/button_widget.dart';
import 'package:voltify/features/Authentication/presentation/widgets/circle_shadow_icon.dart';
import 'package:voltify/features/Authentication/presentation/widgets/secret_textField.dart';
import 'package:voltify/features/Authentication/presentation/widgets/textfield_widget.dart';
import 'package:voltify/features/Home/presentation/views/home.dart';
import 'package:voltify/features/const_themes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String routeName = 'loginScreen';
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> eKey = GlobalKey<FormState>();
  GlobalKey<FormState> pKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInError) {
          StylishDialog(
            context: context,
            alertType: StylishDialogType.ERROR,
            style: DefaultStyle(),
            title: Text('Error'),
            content: Text(state.message),
          ).show();
        }
        if (state is SignInSuccess) {
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            Navigator.pushReplacementNamed(
              context,
              HomeScreens.routeName,
            );
          } else {
            StylishDialog(
              context: context,
              alertType: StylishDialogType.INFO,
              style: DefaultStyle(),
              title: Text('verify your email'),
              content: Text('go to your email to verify your account'),
            ).show();
          }
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignInLoading,
          child: Scaffold(
            backgroundColor: AppTheme.kPrimaryColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleShadowIcon(),
                  Row(
                    children: [
                      SizedBox(
                        width: ScreenSize.width / 30,
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: ScreenSize.width / 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenSize.height / 40,
                  ),
                  CustomTextFormField(
                    textInputType: TextInputType.emailAddress,
                    formKey: eKey,
                    controller: context.read<AuthCubit>().emailIn,
                    title: "Email",
                    hintText: "Enter your email",
                  ),
                  SizedBox(
                    height: ScreenSize.height / 20,
                  ),
                  SecretTextfield(
                    formKey: pKey,
                    controller: context.read<AuthCubit>().passwordIn,
                    title: "Password",
                    hintText: "Enter your password",
                  ),
                  SizedBox(
                    height: ScreenSize.height / 20,
                  ),
                  CustomButton(
                    txt: "Sign In",
                    onTap: () {
                      if (eKey.currentState!.validate() &&
                          pKey.currentState!.validate()) {
                        context.read<AuthCubit>().signInAccount();
                      }
                    },
                  ),
                  SizedBox(
                    height: ScreenSize.height / 40,
                  ),
                  AlreadyHaveAccountWidget(
                    txt: "Don't have an account? ",
                    headline: "Sign Up",
                    onPress: () {
                      Navigator.pushReplacementNamed(
                          context, RegisterationScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
