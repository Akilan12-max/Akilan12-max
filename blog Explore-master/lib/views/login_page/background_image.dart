import 'package:flutter/material.dart';

import '../shared/size_config.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: getProportionateScreenWidth(414),
      height: getProportionateScreenHeight(650),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/map.png'),
        fit: BoxFit.cover,
      )),
      child: Container(
        color: Colors.teal.withOpacity(0.1),
      ),
    );
  }
}
