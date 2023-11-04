import 'package:bilal/bloc/login_bloc/login_bloc.dart';
import 'package:bilal/bloc/login_bloc/login_event.dart';
import 'package:bilal/bloc/login_bloc/login_state.dart';
import 'package:bilal/presentation/screens/common/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  LoginBloc loginBloc = LoginBloc();

  @override
  void initState() {
    loginBloc.add(LoadLogin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          GoRouter.of(context).pushReplacement("/");
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("invalid credentials or connection problem"),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginLoading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case LoginInitial:
          case LoginFailure:
            return const LoginBody();
          case LoginSuccess:
            return HomePage();
          default:
            return const Scaffold(
              body: Center(child: Text("Something went wrong")),
            );
        }
      },
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "السلام عليكم ورحمة الله وبركاته",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email', border: OutlineInputBorder()),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "invalid email!";
                          }
                          return null;
                        }),
                        onSaved: (value) {
                          setState(() {
                            _email = value!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "invalid password";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _password = newValue!;
                          });
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                    }

                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginWithCredentials(
                                            email: _email,
                                            password: _password));
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                ),
                              ),
                            ])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
