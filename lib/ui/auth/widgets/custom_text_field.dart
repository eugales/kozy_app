import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String _labelText;
  final String _hintText;
  final IconData _iconData;
  final TextEditingController _controller;
  final String? Function(String?)? _validator;
  final bool _obscureText;

  const CustomTextField(
      {Key? key,
      required String labelText,
      required String hintText,
      required IconData iconData,
      required TextEditingController controller,
      required String? Function(String?)? validator,
      bool obscureText = false})
      : _labelText = labelText,
        _hintText = hintText,
        _iconData = iconData,
        _controller = controller,
        _validator = validator,
        _obscureText = obscureText,
        super(key: key);

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: _validator,
      obscureText: _obscureText,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: _labelText,
        hintText: _hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        prefixIcon: Icon(
          _iconData,
          color: Colors.black,
          size: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        floatingLabelStyle: const TextStyle(color: Colors.black, fontSize: 18),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade200, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade200, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
