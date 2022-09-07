import 'package:flutter/material.dart';
/*
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    @required this.controller,
    @required this.hintText,
    this.defaultText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String defaultText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.blueGrey[100],
            filled: true,
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear_outlined,
                size: 20,
                color: Colors.red,
              ),
              onPressed: () {
                controller.text = '';
              },
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black)),
        onSaved: (String value) {},
        maxLength: hintText == "Description" ? 100 : 20,
        minLines: hintText == "Description" ? 3 : 1,
        maxLines: hintText == "Description" ? 3 : 1,
      ),
    );
  }
}
*/