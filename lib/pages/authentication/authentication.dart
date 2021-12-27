import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  Get.offAllNamed(RootRoute);
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