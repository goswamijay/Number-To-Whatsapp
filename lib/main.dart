import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MainScreen.dart';

void main() {
  runApp(const MyApp());
}

_launchWhatsapp(String val) async {
  var url = Uri.parse("https://wa.me/$val");
  print(val);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );*/
    print("WhatsApp is not installed on the device");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController phonenumber = TextEditingController();

    String value = "";

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(37, 211, 102, 1),
          title: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "whatsapp-logo.png",
                height: 40,
                color: Colors.white,
              ),
              Image.asset(
                "whatsapp-logo-1.png",
                height: 40,
                color: Colors.white,
              ),
            ]),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            const Center(
              child: Text(
                "Your WhatsApp Number",
                style: TextStyle(
                    color: Color.fromRGBO(35, 164, 85, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            SizedBox(
              height: size.height / 50,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text(
                  "Add mobile Number of the person you want to send message...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            const Center(
              child: Text(
                "Ex-9999888877",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: IntlPhoneField(
                controller: phonenumber,
                initialCountryCode: 'IN',
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (phone) {
                  value = phone.completeNumber;
                  // print(phone.completeNumber);
                },
                onCountryChanged: (country) {
                  value = country.code;
                  //print('Country changed to: ' + country.code);
                },
              ),
            ),
            /*  CountryListPick(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(37, 211, 102, 1),
          title: const Text('Pick your country'),
        ),
        // if you need custom picker use this
        theme: CountryTheme(
          isShowFlag: true,
          isShowTitle: true,
          isShowCode: true,
          isDownIcon: true,
          showEnglishName: true,
          labelColor: Colors.black,
        ),
        initialSelection: '+91',
        onChanged: (CountryCode? code){
          print(code?.name);
        },
        // or
        // initialSelection: 'US'

      ),
             Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextField(
                controller: phonenumber,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Enter Phone Number'),
              ),
            ),*/
            SizedBox(
              height: size.height / 60,
            ),
            MaterialButton(
/*
              onPressed: ()=> _launchWhatsapp(value),
*/
              onPressed: () async {
                var url = Uri.parse('https://wa.me/$value');
                print(value);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("WhatsApp is not installed on the device"),
                    ),
                  );
                  print("WhatsApp is not installed on the device");
                }
              },
              color: const Color.fromRGBO(46, 125, 50, 1),
              child: const Text(
                "Send Message",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
