import 'package:blog/views/shared/size_config.dart';
import 'package:blog/views/login_page/background_image.dart';
import 'package:blog/views/login_page/login_form.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(top: 0, child: BackgroundImage()),
            Positioned(bottom: 0, child: LoginForm())
          ],
        ),
      ));
  }
}
