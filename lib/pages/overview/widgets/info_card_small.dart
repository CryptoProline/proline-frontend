import 'package:flutter/material.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/widgets/custom_text.dart';

class InfoCardSmall extends StatelessWidget {
  final String title; 
  final String value;
  final bool isActive;
  final VoidCallback onClick;
  const InfoCardSmall({ Key? key, required this.title, required this.value, required this.isActive, required this.onClick }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isActive? active: lightGrey, width: 0.5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                size: 24,
                weight: FontWeight.w300,
                color: isActive? active : lightGrey
              ),
              CustomText(
                text: value,
                size: 24,
                weight: FontWeight.bold,
                color: isActive? active : lightGrey
              )
            ],
          )
        )
      )
    );
  }
}