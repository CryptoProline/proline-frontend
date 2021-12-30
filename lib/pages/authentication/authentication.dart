import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/layout.dart';
import 'package:web_ui/routing/routes.dart';
import 'package:web_ui/widgets/custom_text.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:12),
                    child: Image.asset("icons/logo.png")
                  ),
                  Expanded(
                    child: Container()
                  )
                ],
              ),
              const SizedBox(height:30),
              Row(
                children: [
                  Text(
                    "Login", 
                    style: GoogleFonts.roboto(
                      fontSize: 30, fontWeight: FontWeight.bold
                    ))
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: "Welcome Back to the admin panel",
                    color: lightGrey
                  )
                ]
              ),
              const SizedBox(height:15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "abc@domain.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                )
              ),
              const SizedBox(height:15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "123",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                )
              ),
              const SizedBox(height:15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Checkbox(value: true, onChanged: null),
                      CustomText(text: "Remember Me"),
                    ],
                  ),
                  CustomText(
                    text: "Forgot password",
                    color: active,
                  )
                ],
              ),
              const SizedBox(height:15),
              InkWell(
                onTap: () {
                  launchURL();
                  // Get.offAllNamed(RootRoute);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:active
                  ),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const CustomText(
                      text: "Login",
                      color: Colors.white
                    ),
                )
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "Do not have admin credentials?"),
                    TextSpan(text: "Request credentials!", style: TextStyle(color:active))
                  ]
                )
              )
            ],
          )
        )
      ),
    );
  }
}


launchURL() async {
//  const url = 'https://auth.cryptoproline.com/login?client_id=b5u050lva45encgtl4atvcc7s&response_type=code&scope=email+openid&redirect_uri=http://localhost:8080/callback';
  String url =
      "${dotenv.env['AUTH_URI']}?client_id=${dotenv.env['CLIENT_ID']}&response_type=code&scope=email+openid&redirect_uri=${dotenv.env['REDIRECT_URI']}";
  print("url:" + url);
  if (await canLaunch(url)) {
    await launch(url, webOnlyWindowName: '_self');
  } else {
    throw 'Could not launch $url';
  }
}