import 'package:blog/models/user_model.dart';
import 'package:blog/services/networking/api_response.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'size_config.dart';

Future<void> processingDialog({context, nextPage, blocStream}) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: Container(
              height: getProportionateScreenHeight(159),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: JumpingDotsProgressIndicator(
                        fontSize: 30.0,
                        color: Colors.teal,
                        numberOfDots: 3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  StreamBuilder<ApiResponse<User>>(
                    stream: blocStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            return Text('Processing',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                ));
                            break;
                          case Status.COMPLETED:
                            TokenNotifier.token = snapshot.data.data.token;
                            print("token --- ${snapshot.data.data.token}");
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => nextPage,
                                ),
                              ),
                            );
                            break;
                          case Status.ERROR:
                            Navigator.pop(context);
                        }
                      }
                      return Container(
                          child: Text('Processing',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                              )));
                    },
                  )
                ],
              ),
            ),
          ),
        );
      });
}
