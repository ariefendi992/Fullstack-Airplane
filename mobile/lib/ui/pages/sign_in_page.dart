import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:airplane/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          'Sign in with your\nexisting account',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: email,
              title: 'Email Address',
              hintText: 'ex. ariefendi@gmail.com',
            ),
            CustomTextFormField(
              controller: password,
              title: 'Password',
              hintText: 'Password',
              obSecureText: true,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  context.read<AuthCubit>().currentUser();

                  Navigator.pushNamedAndRemoveUntil(
                      context, '/main', (route) => false);
                } else if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    state.error,
                    style: whiteTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  )));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomButton(
                  title: 'Sign In',
                  margin: const EdgeInsets.only(top: 10),
                  onPressed: () {
                    context.read<AuthCubit>().signIn(
                          email: email.text,
                          password: password.text,
                        );
                  },
                );
              },
            ),
          ],
        ),
      );
    }

    Widget btnTerm() {
      return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 70),
        child: TextButton(
          child: Text(
            "have an account? Sign Up",
            style: blackTextStyle.copyWith(
              color: kSecondaryColor,
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
        ),
      );
    }

    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      children: [
        title(),
        inputSection(),
        btnTerm(),
      ],
    )));
  }
}
