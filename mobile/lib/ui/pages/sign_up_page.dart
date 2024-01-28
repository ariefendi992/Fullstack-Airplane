import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:airplane/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController hobby = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          'Join us and get\nyour next journey',
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
              controller: fullName,
              title: 'Full Name',
              hintText: 'Your full name',
            ),
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
            CustomTextFormField(
              controller: hobby,
              title: 'Hobby',
              hintText: 'Hobby',
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  // Navigator.pushNamed(context, '/signin');
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/bonus', (route) => false);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text(
                  //   state.user.additonal!['msg'],
                  //   style: whiteTextStyle.copyWith(
                  //     fontWeight: medium,
                  //   ),
                  // )));
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
                  title: 'Sign Up',
                  margin: const EdgeInsets.only(top: 10),
                  onPressed: () {
                    context.read<AuthCubit>().signUp(
                        email: email.text,
                        password: password.text,
                        name: fullName.text,
                        hobby: hobby.text);
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
            "Dont have an account? Sign In",
            style: blackTextStyle.copyWith(
              color: kSecondaryColor,
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/signin');
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
