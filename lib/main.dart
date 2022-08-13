import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:html5_test/verify.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

var _phnController = TextEditingController();
final _messengerKey = GlobalKey<ScaffoldMessengerState>();

class _MyAppState extends State<MyApp> {
  static const title_style = TextStyle(
    color: Colors.blueAccent,
    fontFamily: "Irs",
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
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
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "تایید حساب کاربری",
              style: TextStyle(
                  fontFamily: "Irs", fontSize: 20, color: Colors.black),
            ),
            centerTitle: true,
            // leading: InkWell(
            //   onTap: () {},
            //   child: Icon(
            //     Icons.arrow_back,
            //     color: Colors.black45,
            //   ),
            // ),
            backgroundColor: Colors.white,
            elevation: 2,
          ),
          body: Center(
              child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextField(
                  controller: _phnController,
                  textAlign: TextAlign.center,
                  style: input_title,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "شماره موبایل",
                    hintStyle: hint_text,
                    suffixIcon: Icon(Icons.phone_android),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextButton(
                  onPressed: () {
                    sendLoginRequest(
                        context: context, phn: _phnController.text);
                  },
                  child: Text(
                    "ارسال کد",
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(340, 46),
                    primary: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    elevation: 10,
                    textStyle: TextStyle(fontSize: 18, fontFamily: "Irs"),
                  ),
                ),
              )
            ],
          )),
        );
      }),
    );
  }

  void sendLoginRequest({
    required BuildContext context,
    required String phn,
  }) async {
    String verifyCode = getRandomString(6);
    Map<String, dynamic> body = {
      "Mobile": phn,
      "TemplateId": 620007,
      "Parameters": [
        {
          "Name": "CODE",
          "Value": verifyCode,
        }
      ],
    };
    Map<String, String> header = {
      "Content-Type": "application/json",
      "ACCEPT": "application/json",
      "X-API-KEY":
          "mcmtnayRu1f9h1oxbAmfRTDitUSDaM9QGV4ZWwaZgIAegBamd7IneR1dAKuUdc97"
    };

    Response response = await post(
        Uri.parse('https://api.sms.ir/v1/send/verify'),
        body: json.encode(body),
        headers: header);

    print(verifyCode);
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Verify(verifyCode)));
      // ShowMySnackBar(context, "کد تایید به شماره همراه شما ارسال شد");
    } else {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Verify(verifyCode)));
      ShowMySnackBar(context, "دوباره امتحان کنید");
    }
  }

  // Generate Random Code
  final String _chars = '1234567890';
  Random rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));

  // Show Snack Bar
  void ShowMySnackBar(BuildContext context, String message) {
    _messengerKey.currentState!.showSnackBar(
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
