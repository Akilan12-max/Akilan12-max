import 'package:blog/blocs/email_password_bloc.dart';
import 'package:blog/blocs/login_bloc.dart';
import 'package:blog/views/blog_list_page/blog_list_view.dart';
import 'package:blog/views/shared/processing_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/size_config.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _bloc = Bloc();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(420),
      width: getProportionateScreenWidth(414),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getProportionateScreenHeight(40)),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20)),
              child: StreamBuilder<String>(
                stream: _bloc.email,
                builder: (context, snapshot) => TextField(
                  onChanged: _bloc.emailChanged,
                  keyboardType: TextInputType.text,
                  controller: emailController,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                          left: getProportionateScreenWidth(14),
                          top: getProportionateScreenHeight(13),
                          bottom: getProportionateScreenHeight(13)),
                      hintText: 'Enter Email',
                      isDense: true,
                      hintStyle: GoogleFonts.signika(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                      labelText: 'Email'),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20)),
              child: StreamBuilder<String>(
                stream: _bloc.password,
                builder: (context, snapshot) => TextField(
                  onChanged: _bloc.passwordChanged,
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                          left: getProportionateScreenWidth(14),
                          top: getProportionateScreenHeight(13),
                          bottom: getProportionateScreenHeight(13)),
                      hintText: 'Enter Password',
                      isDense: true,
                      hintStyle: GoogleFonts.signika(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                      labelText: 'Password'),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            StreamBuilder<bool>(
                stream: _bloc.submitCheck,
                builder: (context, snapshot) {
                  return Container(
                    height: getProportionateScreenHeight(58),
                    width: getProportionateScreenWidth(354),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RaisedButton(
                      onPressed: snapshot.hasData
                          ? () => loginUser(snapshot.data)
                          : null,
                      color: Colors.teal.withOpacity(0.35),
                      child: Container(
                        height: getProportionateScreenHeight(58),
                        width: getProportionateScreenWidth(354),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: GoogleFonts.signika(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  loginUser(data) {
    // print(emailController.text);
    // print(passwordController.text);
    processingDialog(
        blocStream: LoginBloc(email: emailController.text, password: passwordController.text).loginStream,
        context: context,
        nextPage: BlogListView());
  }

  @override
  void dispose() {
    LoginBloc().dispose();
    super.dispose();
  }
}
