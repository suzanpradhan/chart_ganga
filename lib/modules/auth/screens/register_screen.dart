import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/models/user_model.dart';
import 'package:chart_ganga/modules/auth/blocs/register/register_bloc.dart';
import 'package:chart_ganga/widgets/custom_button.dart';
import 'package:chart_ganga/widgets/form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
          emailController: _emailController,
          passowrdController: _passwordController,
          usernameController: _usernameController),
      child: Scaffold(
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is UserRegisterFailedState) {
              print("oleoleole");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is RegisterAttemptLoadingState) {
              print("loading..................");
            } else if (state is UserRegisteredState) {
              print("logged in");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 32,
                              ),
                              Center(
                                child: Text(
                                  "Chart Ganga",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              SizedBox(
                                height: 52,
                              ),
                              Text(
                                "Create your account",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              FormInput(
                                controller: _usernameController,
                                placeholder: "Username",
                                errorMessage: (context
                                            .read<RegisterBloc>()
                                            .state is RegisterFormErrorState &&
                                        !(context.read<RegisterBloc>().state
                                                as RegisterFormErrorState)
                                            .hasUsernameError())
                                    ? (context.read<RegisterBloc>().state
                                            as RegisterFormErrorState)
                                        .usernameError
                                    : null,
                                onChanged: (value) {
                                  BlocProvider.of<RegisterBloc>(context).add(
                                      UsernameValidate(
                                          errorState: (context
                                                      .read<RegisterBloc>()
                                                      .state
                                                  is RegisterFormErrorState)
                                              ? context
                                                      .read<RegisterBloc>()
                                                      .state
                                                  as RegisterFormErrorState
                                              : null,
                                          username: value));
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              FormInput(
                                controller: _emailController,
                                placeholder: "Email",
                                errorMessage: (context
                                            .read<RegisterBloc>()
                                            .state is RegisterFormErrorState &&
                                        !(context.read<RegisterBloc>().state
                                                as RegisterFormErrorState)
                                            .hasEmailAddressError())
                                    ? (context.read<RegisterBloc>().state
                                            as RegisterFormErrorState)
                                        .emailAddressError
                                    : null,
                                onChanged: (value) {
                                  BlocProvider.of<RegisterBloc>(context).add(
                                      EmailValidate(
                                          errorState: (context
                                                      .read<RegisterBloc>()
                                                      .state
                                                  is RegisterFormErrorState)
                                              ? context
                                                      .read<RegisterBloc>()
                                                      .state
                                                  as RegisterFormErrorState
                                              : null,
                                          emailAddress: value));
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              FormInput(
                                controller: _passwordController,
                                placeholder: "Password",
                                obsecureText: true,
                                errorMessage: (context
                                            .read<RegisterBloc>()
                                            .state is RegisterFormErrorState &&
                                        !(context.read<RegisterBloc>().state
                                                as RegisterFormErrorState)
                                            .hasPasswordError())
                                    ? (context.read<RegisterBloc>().state
                                            as RegisterFormErrorState)
                                        .passwordError
                                    : null,
                                onChanged: (value) {
                                  BlocProvider.of<RegisterBloc>(context).add(
                                      PasswordValidate(
                                          errorState: (context
                                                      .read<RegisterBloc>()
                                                      .state
                                                  is RegisterFormErrorState)
                                              ? context
                                                      .read<RegisterBloc>()
                                                      .state
                                                  as RegisterFormErrorState
                                              : null,
                                          password: value));
                                },
                              ),
                              // SizedBox(
                              //   height: 18,
                              // ),
                              // FormInput(
                              //   controller: _confirmPasswordController,
                              //   placeholder: "Confirm password",
                              //   obsecureText: true,
                              // ),
                              SizedBox(
                                height: 18,
                              ),
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  return CustomButton(
                                    isLoading:
                                        (state is RegisterAttemptLoadingState),
                                    text: "REGISTER",
                                    onTap: () {
                                      if (state is RegisterFormValidated) {
                                        BlocProvider.of<RegisterBloc>(context)
                                            .add(RegisterFormSubmitted(
                                                userModel: UserModel(
                                                    email:
                                                        _emailController.text,
                                                    username:
                                                        _usernameController
                                                            .text,
                                                    password:
                                                        _passwordController
                                                            .text)));
                                      }
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  child: RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        children: [
                                          TextSpan(
                                              text:
                                                  "Already have an account? "),
                                          TextSpan(
                                              text: "Sign in",
                                              style: TextStyle(
                                                  color: CustomColors
                                                      .purpleRegular))
                                        ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              "Terms and conditions",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
