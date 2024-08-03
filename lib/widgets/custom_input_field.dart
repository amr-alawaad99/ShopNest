import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/const/constants.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final bool filled;
  final bool haveBorder;
  final bool prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.hintText,
    this.labelText,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.filled = false,
    this.haveBorder = false,
    this.prefixIcon = false,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.9.sw,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: (widget.labelText != null)
                ? Text(
                    widget.labelText!,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  )
                : null,
          ),
          TextFormField(
            obscureText: (widget.obscureText && _obscureText),
            decoration: InputDecoration(
              filled: widget.filled,
              border: widget.haveBorder
                  ? OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(25.sp))
                  : null,
              fillColor: Constants.secondaryColor,
              isDense: (widget.isDense != null) ? widget.isDense : false,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              suffixIconConstraints: (widget.isDense != null)
                  ? const BoxConstraints(maxHeight: 33)
                  : null,
              prefixIcon: widget.prefixIcon ? const Icon(Icons.search) : null,
            ),
            validator: widget.validator,
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}
