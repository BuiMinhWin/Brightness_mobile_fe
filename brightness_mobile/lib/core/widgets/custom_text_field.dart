import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? value;
  final ValueChanged<String>? onChanged;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final String? helperText;
  final bool showCounter;

  const CustomTextField({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.controller,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.helperText,
    this.showCounter = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _obscureText = true;
  bool _hasError = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    
    if (widget.value != null) {
      _controller.text = widget.value!;
    }
    
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
    }
    
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? _controller;
    }
    
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      _focusNode = widget.focusNode ?? _focusNode;
      _focusNode.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && widget.validator != null) {
      _validateField();
    }
  }

  void _validateField() {
    final error = widget.validator?.call(_controller.text);
    setState(() {
      _hasError = error != null;
      _errorText = error;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppTheme.textSecondary,
        ),
        onPressed: _togglePasswordVisibility,
      );
    }
    
    return null;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (_hasError) {
              _validateField();
            }
          },
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          validator: (value) {
            final error = widget.validator?.call(value);
            setState(() {
              _hasError = error != null;
              _errorText = error;
            });
            return error;
          },
          decoration: AppTheme.inputDecoration(
            label: widget.label,
            hint: widget.hint,
            prefixIcon: widget.prefixIcon,
            suffixIcon: _buildSuffixIcon(),
            isError: _hasError,
          ).copyWith(
            helperText: widget.helperText,
            counterText: widget.showCounter ? null : '',
          ),
        ),
        if (_hasError && _errorText != null) ...[
          const SizedBox(height: AppTheme.spacingXS),
          Text(
            _errorText!,
            style: AppTheme.textStyleError,
          ),
        ],
      ],
    );
  }
}
