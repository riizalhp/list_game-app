import 'package:flutter/material.dart';

import '../../theme.dart';

class CustomTextField extends StatelessWidget {
  final String nameTextField;
  final Widget iconTextField;
  final TextEditingController controller;
  final bool isPassword;
  final bool isEnabled;

  const CustomTextField({
    Key? key,
    required this.nameTextField,
    required this.iconTextField,
    required this.controller,
    this.isEnabled = true,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            cursorColor: Colors.green,
            enabled: isEnabled,
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: nameTextField,
              hintStyle: kBlackTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 16,
                color: isEnabled
                    ? const Color.fromARGB(255, 159, 158, 158)
                    : Colors.green,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Container(
                padding: EdgeInsets.only(
                    right: 8.0), // Space between icon and divider
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconTextField,
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: VerticalDivider(
                        color: Colors.grey,
                        width: 1.0,
                        thickness: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              suffixIconColor: const Color.fromARGB(255, 124, 126, 124),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: const BorderSide(
              //     width: 1,
              //     color: Colors.white,
              //   ),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              // border: OutlineInputBorder(
              //   borderSide: const BorderSide(
              //     width: 2,
              //     style: BorderStyle.none,
              //   ),
              //   borderRadius: BorderRadius.circular(10),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
