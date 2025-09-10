import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum ButtonType { primary, secondary, outline, text, icon }

class CustomButton extends StatelessWidget {
  // Deduplicated fields
  final String? text;
  final VoidCallback? onPressed;
  final bool isEnabled; // for onboarding usage
  final bool isLoading;
  final bool isDisabled; // backward-compat with previous API
  final double? width;
  final double? height;
  final Gradient? gradient;

  // Variant styling
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final ButtonType type;
  final IconData? icon;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double? elevation;
  final TextStyle? textStyle;
  final bool fullWidth;
  final bool expand;
  final String? tooltip;
  final double? iconSize;
  final MainAxisAlignment? alignment;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height = 56,
    this.gradient,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.type = ButtonType.primary,
    this.icon,
    this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation,
    this.textStyle,
    this.fullWidth = true,
    this.expand = false,
    this.tooltip,
    this.iconSize,
    this.alignment,
  });

  const CustomButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
    this.icon,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation,
    this.textStyle,
    this.fullWidth = true,
    this.expand = false,
    this.tooltip,
    this.iconSize,
    this.alignment,
    this.backgroundColor,
    this.textColor,
  }) : gradient = null,
       borderColor = null,
       type = ButtonType.primary,
       child = null;

  const CustomButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
    this.icon,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation,
    this.textStyle,
    this.fullWidth = true,
    this.expand = false,
    this.tooltip,
    this.iconSize,
    this.alignment,
    this.backgroundColor,
    this.textColor,
  }) : gradient = null,
       borderColor = null,
       type = ButtonType.secondary,
       child = null;

  const CustomButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
    this.icon,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation,
    this.textStyle,
    this.fullWidth = true,
    this.expand = false,
    this.tooltip,
    this.iconSize,
    this.alignment,
    this.textColor,
    this.borderColor,
  }) : gradient = null,
       backgroundColor = null,
       type = ButtonType.outline,
       child = null;

  const CustomButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
    this.icon,
    this.padding,
    this.margin,
    this.borderRadius,
    this.textStyle,
    this.fullWidth = false,
    this.expand = false,
    this.tooltip,
    this.iconSize,
    this.alignment,
    this.textColor,
  }) : elevation = 0,
       gradient = null,
       backgroundColor = null,
       borderColor = null,
       type = ButtonType.text,
       child = null;

  const CustomButton.icon({
    super.key,
    required this.icon,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation,
    this.fullWidth = false,
    this.expand = false,
    this.tooltip,
    this.iconSize,
    this.alignment,
    this.backgroundColor,
    this.textColor,
  }) : text = null,
       gradient = null,
       borderColor = null,
       type = ButtonType.icon,
       child = null,
       textStyle = null;

  bool get _canPress =>
      isEnabled && !isDisabled && !isLoading && onPressed != null;
  BorderRadius get _radius => borderRadius ?? BorderRadius.circular(16);

  Color get _contentColor {
    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
      case ButtonType.icon:
        return textColor ?? AppColors.white;
      case ButtonType.outline:
      case ButtonType.text:
        return textColor ?? AppColors.primary;
    }
  }

  TextStyle get _labelStyle =>
      (textStyle ?? AppTextStyles.button).copyWith(color: _contentColor);

  Color get _bgColorFilled {
    switch (type) {
      case ButtonType.primary:
        return backgroundColor ?? AppColors.primary;
      case ButtonType.secondary:
        return backgroundColor ?? AppColors.secondary;
      case ButtonType.icon:
        return backgroundColor ?? AppColors.primary;
      case ButtonType.outline:
      case ButtonType.text:
        return Colors.transparent;
    }
  }

  Widget _buildInner() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: AppColors.white,
          strokeWidth: 2,
        ),
      );
    }

    if (child != null) return child!;
    final label = Text(text ?? '', style: _labelStyle);

    if (icon != null && type != ButtonType.icon) {
      return Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: alignment ?? MainAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize ?? 20, color: _contentColor),
          const SizedBox(width: 8),
          label,
        ],
      );
    }

    if (type == ButtonType.icon) {
      return Icon(icon, size: iconSize ?? 24, color: _contentColor);
    }

    return label;
  }

  @override
  Widget build(BuildContext context) {
    final childWidget = _buildInner();

    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        final base = ElevatedButton(
          onPressed: _canPress ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _bgColorFilled,
            disabledBackgroundColor: AppColors.border,
            elevation: elevation ?? 0,
            shape: RoundedRectangleBorder(borderRadius: _radius),
            padding: padding,
            minimumSize: Size(
              width ?? (fullWidth ? double.infinity : 56),
              (height ?? 56),
            ),
          ),
          child: childWidget,
        );

        if (gradient != null) {
          return SizedBox(
            width: width ?? double.infinity,
            height: height ?? 56,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: _radius,
              ),
              child: ElevatedButton(
                onPressed: _canPress ? onPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  disabledBackgroundColor: AppColors.border,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: _radius),
                ),
                child: childWidget,
              ),
            ),
          );
        }
        return base;

      case ButtonType.outline:
        return SizedBox(
          width: width ?? (fullWidth ? double.infinity : null),
          height: height ?? 56,
          child: OutlinedButton(
            onPressed: _canPress ? onPressed : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: _contentColor,
              side: BorderSide(color: borderColor ?? AppColors.primary),
              shape: RoundedRectangleBorder(borderRadius: _radius),
              padding: padding,
            ),
            child: childWidget,
          ),
        );

      case ButtonType.text:
        final btn = TextButton(
          onPressed: _canPress ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: _contentColor,
            shape: RoundedRectangleBorder(borderRadius: _radius),
            padding: padding,
          ),
          child: childWidget,
        );
        return width != null || height != null
            ? SizedBox(width: width, height: height, child: btn)
            : btn;

      case ButtonType.icon:
        return IconButton(
          onPressed: _canPress ? onPressed : null,
          icon: childWidget,
          style: IconButton.styleFrom(
            backgroundColor: _bgColorFilled,
            shape: RoundedRectangleBorder(borderRadius: _radius),
            padding: padding,
          ),
        );
    }
  }
}
