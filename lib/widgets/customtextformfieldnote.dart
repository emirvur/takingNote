/*import 'package:flutter/material.dart';
import 'package:tea/utils/constants/size.dart';

class CustomTextFormFieldNote extends StatelessWidget {
  const CustomTextFormFieldNote({
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
      padding: const EdgeInsets.all(CentralSize.generalPadding),
      child: TextFormField(
        minLines: 10,
        maxLines: 10,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(CentralSize.borderradius),
            ),
            fillColor: Colors.blueGrey[100],
            filled: true,
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear_outlined,
                size: CentralSize.iconSize,
                color: Colors.red,
              ),
              onPressed: () {
                controller.text = '';
              },
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black)),
        onSaved: (String value) {},
        maxLength: 100,
      ),
    );
  }
}
*/