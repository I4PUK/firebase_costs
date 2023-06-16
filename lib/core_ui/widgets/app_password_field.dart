import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppPasswordField extends StatefulWidget {
  final TextEditingController controller;

  final bool? isEnabled;
  final String? hintText;
  final String? infoText;
  final String? errorText;
  final Widget? suffixIcon;
  final Color? additionalColor;
  final TextInputType? keyboardType;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;

  const AppPasswordField({
    required this.controller,
    this.hintText,
    this.onChange,
    this.infoText,
    this.isEnabled,
    this.suffixIcon,
    this.errorText,
    this.keyboardType,
    this.additionalColor,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _isShowPassword = true;

  void _showPasswordListener() {
    setState(() {
      _isShowPassword = !_isShowPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.infoText != null) ...<Widget>{
          Text(
            widget.infoText!,
          ),
          const SizedBox(height: 8.0),
        },
        TextFormField(
          obscureText: _isShowPassword,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          onChanged: widget.onChange,
          enabled: widget.isEnabled,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.errorText,
          ).applyDefaults(Theme.of(context).inputDecorationTheme).copyWith(
                hintText: widget.hintText,
                suffixIcon: _isShowPassword
                    ? IconButton(
                        onPressed: _showPasswordListener,
                        icon: const Icon(Icons.visibility),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      )
                    : IconButton(
                        onPressed: _showPasswordListener,
                        icon: const Icon(Icons.visibility_off),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
              ),
        ),
      ],
    );
  }
}
