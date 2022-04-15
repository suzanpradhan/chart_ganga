import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/models/user_model.dart';
import 'package:chart_ganga/modules/auth/blocs/login/login_bloc.dart';
import 'package:chart_ganga/modules/auth/screens/register_screen.dart';
import 'package:chart_ganga/widgets/custom_button.dart';
import 'package:chart_ganga/widgets/form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          usernameController: _usernameController,
          passowrdController: _passwordController),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is UserLoggedInFailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is UserLoggedInState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.of(context).pushNamed(HOMEPAGE_ROUTE);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
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
                                "Login into your account",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              FormInput(
                                controller: _usernameController,
                                placeholder: "Username",
                                errorMessage: (context.read<LoginBloc>().state
                                            is LoginFormErrorState &&
                                        !(context.read<LoginBloc>().state
                                                as LoginFormErrorState)
                                            .hasUsernameError())
                                    ? (context.read<LoginBloc>().state
                                            as LoginFormErrorState)
                                        .usernameError
                                    : null,
                                onChanged: (value) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      UsernameValidate(
                                          errorState: (context
                                                  .read<LoginBloc>()
                                                  .state is LoginFormErrorState)
                                              ? context.read<LoginBloc>().state
                                                  as LoginFormErrorState
                                              : null,
                                          username: value));
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              FormInput(
                                controller: _passwordController,
                                placeholder: "Password",
                                obsecureText: true,
                                errorMessage: (context.read<LoginBloc>().state
                                            is LoginFormErrorState &&
                                        !(context.read<LoginBloc>().state
                                                as LoginFormErrorState)
                                            .hasPasswordError())
                                    ? (context.read<LoginBloc>().state
                                            as LoginFormErrorState)
                                        .passwordError
                                    : null,
                                onChanged: (value) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      PasswordValidate(
                                          errorState: (context
                                                  .read<LoginBloc>()
                                                  .state is LoginFormErrorState)
                                              ? context.read<LoginBloc>().state
                                                  as LoginFormErrorState
                                              : null,
                                          password: value));
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      "Forget Password?",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                              ),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  return CustomButton(
                                    isLoading:
                                        (state is LoginAttemptLoadingState),
                                    text: "LOGIN",
                                    onTap: () {
                                      if (state is LoginFormValidated) {
                                        BlocProvider.of<LoginBloc>(context).add(
                                            LoginFormSubmit(
                                                userModel: UserModel(
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
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, REGISTER_ROUTE);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        children: [
                                          TextSpan(
                                              text: "Don't have an account? "),
                                          TextSpan(
                                              text: "Sign up",
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
