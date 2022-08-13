import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

void main() {
  String verifyCode = "";
  runApp(Verify(verifyCode));
}

class Verify extends StatelessWidget {
  final _messenger2Key = GlobalKey<ScaffoldMessengerState>();

  String verifyCode;
  Verify(this.verifyCode);

  static const title_style = TextStyle(
    color: Colors.blueAccent,
    fontFamily: "Irs",
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
  );

  static const title2_style = TextStyle(
    color: Colors.black,
    fontFamily: "Irs",
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const input_title = TextStyle(
    color: Colors.blueAccent,
    fontFamily: "Irs",
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  static const hint_text = TextStyle(
    color: Colors.black45,
    fontFamily: "Irs",
    fontSize: 14,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messenger2Key,
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 2,
          ),
          body: Center(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "تایید کد",
                style: title2_style,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ": لطفا کد 6 رقمی پیامک شده وارد نمایید",
                style: TextStyle(fontFamily: "Irs"),
              ),
              SizedBox(
                height: 30,
              ),
              VerificationCode(
                textStyle: TextStyle(
                    fontSize: 24.0,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                fullBorder: true,
                underlineColor: Colors.blueAccent,
                length: 6,
                cursorColor: Colors.blue,
                onCompleted: (String value) {
                  if (value == verifyCode) {
                    ShowMySnackBar(context, "شماره موبایل شما تایید شد");
                  } else {
                    ShowMySnackBar(context, "کد وارد شده صحیح نمی‌باشد");
                  }
                },
                onEditing: (bool value) {},
              ),
              SizedBox(
                height: 34,
              ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              //   child: TextField(
              //     controller: _codeController,
              //     textAlign: TextAlign.center,
              //     style: input_title,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //       hintText: "کد دریافتی",
              //       hintStyle: hint_text,
              //       suffixIcon: Icon(Icons.mail),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              //   child: TextButton(
              //     onPressed: () {
              //       if (_codeController.text == verifyCode) {
              //         ShowMySnackBar(context, "شماره موبایل شما تایید شد");
              //       } else {
              //         ShowMySnackBar(context, "کد وارد شده صحیح نمی‌باشد");
              //       }
              //     },
              //     child: Text(
              //       "تایید",
              //     ),
              //     style: TextButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10)),
              //       fixedSize: Size(340, 46),
              //       primary: Colors.white,
              //       backgroundColor: Colors.blueAccent,
              //       elevation: 10,
              //       textStyle: TextStyle(fontSize: 18, fontFamily: "Irs"),
              //     ),
              //   ),
              // )
            ],
          )),
        );
      }),
    );
  }

  // Show Snack Bar
  void ShowMySnackBar(BuildContext context, String message) {
    _messenger2Key.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          message,
          style: TextStyle(
              fontFamily: "Irs",
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        elevation: 5,
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'تایید',
          onPressed: () {},
          textColor: Colors.yellowAccent,
        ),
      ),
    );
  }
}
