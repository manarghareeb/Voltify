import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:voltify/features/Authentication/cubit/auth_cubit.dart';
import 'package:voltify/features/Authentication/presentation/views/login_view.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/Authentication/presentation/widgets/already_have_account.dart';
import 'package:voltify/features/Authentication/presentation/widgets/button_widget.dart';
import 'package:voltify/features/Authentication/presentation/widgets/circle_shadow_icon.dart';
import 'package:voltify/features/Authentication/presentation/widgets/phone_field.dart';
import 'package:voltify/features/Authentication/presentation/widgets/secret_textField.dart';
import 'package:voltify/features/Authentication/presentation/widgets/textfield_widget.dart';
import 'package:voltify/features/home%20entry%20details/presentation/views/home_type_view.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});
  static String routeName = 'RegisterationScreen';

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacementNamed(context, HomeTypeView.routeName);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Sign up successful",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignUpLoading,
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
                        "Sign Up",
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
                    textInputType: TextInputType.name,
                    formKey: nameKey,
                    controller: context.read<AuthCubit>().name,
                    title: "Name",
                    hintText: "Enter your name",
                  ),
                  SizedBox(
                    height: ScreenSize.height / 40,
                  ),
                  CustomTextFormField(
                    textInputType: TextInputType.emailAddress,
                    formKey: emailKey,
                    controller: context.read<AuthCubit>().emailUP,
                    title: "Email",
                    hintText: "Enter your email",
                  ),
                  SizedBox(
                    height: ScreenSize.height / 40,
                  ),
                  SecretTextfield(
                    hintText: "Enter your password",
                    controller: context.read<AuthCubit>().passwordUP,
                    title: "Password",
                    formKey: passwordKey,
                  ),
                  SizedBox(
                    height: ScreenSize.height / 40,
                  ),
                  PhoneField(
                    controller: context.read<AuthCubit>().phone,
                    formKey: phoneKey,
                  ),
                  SizedBox(
                    height: ScreenSize.height / 20,
                  ),
                  CustomButton(
                    txt: "Sign Up",
                    onTap: () {
                      if (nameKey.currentState!.validate() &&
                          emailKey.currentState!.validate() &&
                          passwordKey.currentState!.validate() &&
                          phoneKey.currentState!.validate()) {
                        context.read<AuthCubit>().signupAccount();
                      }
                    },
                  ),
                  SizedBox(
                    height: ScreenSize.height / 40,
                  ),
                  AlreadyHaveAccountWidget(
                    txt: "Already have an account? ",
                    headline: "Sign In",
                    onPress: () {
                      Navigator.pushReplacementNamed(
                          context, LoginView.routeName);
                    },
                  ),
                  SizedBox(
                    height: ScreenSize.height / 30,
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


/*
SingleChildScrollView(
        child: Column(
          children: [
            const CircleShadowIcon(),
            Row(
              children: [
                SizedBox(
                  width: ScreenSize.width / 30,
                ),
                Text(
                  "Sign Up",
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
           
          ],
        ),
      ),
 */