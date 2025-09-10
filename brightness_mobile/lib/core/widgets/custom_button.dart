import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;
  final double? width;
  final double height;
  final Gradient? gradient;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.width,
    this.height = 56,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    final buttonChild = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 2,
            ),
          )
        : Text(text, style: AppTextStyles.button);

    if (gradient != null) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: borderRadius,
          ),
          child: ElevatedButton(
            onPressed: isEnabled && !isLoading ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: AppColors.border,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            child: buttonChild,
          ),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.border,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          elevation: 0,
        ),
        child: buttonChild,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum ButtonType { primary, secondary, outline, text, icon }

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double? height;
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
    this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
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
    this.backgroundColor,
    this.textColor,
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
  }) : type = ButtonType.primary,
       child = null,
       borderColor = null;

  const CustomButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
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
  }) : type = ButtonType.secondary,
       child = null,
       borderColor = null;

  const CustomButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
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
  }) : type = ButtonType.outline,
       child = null;

  const CustomButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
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
  }) : type = ButtonType.text,
       child = null,
       backgroundColor = null,
       borderColor = null,
       elevation = 0;

  const CustomButton.icon({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
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
  }) : type = ButtonType.icon,
       text = null,
       child = null,
       textStyle = null;

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;

  Color get _effectiveBackgroundColor {
    if (!_isEnabled) return AppTheme.textHint;
    
    switch (type) {
      case ButtonType.primary:
        return backgroundColor ?? AppTheme.primaryColor;
      case ButtonType.secondary:
        return backgroundColor ?? AppTheme.secondaryColor;
      case ButtonType.outline:
        return backgroundColor ?? Colors.transparent;
      case ButtonType.text:
        return backgroundColor ?? Colors.transparent;
      case ButtonType.icon:
        return backgroundColor ?? AppTheme.primaryColor;
    }
  }

  Color get _effectiveTextColor {
    if (!_isEnabled) return AppTheme.textHint;
    
    switch (type) {
      case ButtonType.primary:
        return textColor ?? AppTheme.surfaceColor;
      case ButtonType.secondary:
        return textColor ?? AppTheme.surfaceColor;
      case ButtonType.outline:
        return textColor ?? AppTheme.primaryColor;
      case ButtonType.text:
        return textColor ?? AppTheme.primaryColor;
      case ButtonType.icon:
        return textColor ?? AppTheme.surfaceColor;
    }
  }

  Color get _effectiveBorderColor {
    if (!_isEnabled) return AppTheme.textHint;
    
    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
      case ButtonType.text:
      case ButtonType.icon:
        return Colors.transparent;
      case ButtonType.outline:
        return borderColor ?? AppTheme.primaryColor;
    }
  }

  double get _effectiveElevation {
    if (!_isEnabled) return 0;
    return elevation ?? (type == ButtonType.primary ? AppTheme.elevationS : 0);
  }

  EdgeInsetsGeometry get _effectivePadding {
    if (padding != null) return padding!;
    
    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingL,
          vertical: AppTheme.spacingM,
        );
      case ButtonType.outline:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingL,
          vertical: AppTheme.spacingM,
        );
      case ButtonType.text:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingS,
        );
      case ButtonType.icon:
        return const EdgeInsets.all(AppTheme.spacingM);
    }
  }

  BorderRadius get _effectiveBorderRadius {
    return borderRadius ?? BorderRadius.circular(AppTheme.radiusM);
  }

  TextStyle get _effectiveTextStyle {
    if (textStyle != null) return textStyle!;
    
    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return AppTheme.textStyleButton.copyWith(color: _effectiveTextColor);
      case ButtonType.outline:
        return AppTheme.textStyleButton.copyWith(color: _effectiveTextColor);
      case ButtonType.text:
        return AppTheme.textStyleBody1.copyWith(color: _effectiveTextColor);
      case ButtonType.icon:
        return AppTheme.textStyleButton.copyWith(color: _effectiveTextColor);
    }
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: AppTheme.iconSizeM,
        height: AppTheme.iconSizeM,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_effectiveTextColor),
        ),
      );
    }

    if (child != null) return child!;

    switch (type) {
      case ButtonType.icon:
        return Icon(
          icon,
          color: _effectiveTextColor,
          size: iconSize ?? AppTheme.iconSizeM,
        );
      default:
        if (icon != null && text != null) {
          return Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: alignment ?? MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _effectiveTextColor,
                size: iconSize ?? AppTheme.iconSizeS,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(text!, style: _effectiveTextStyle),
            ],
          );
        } else if (text != null) {
          return Text(text!, style: _effectiveTextStyle);
        } else {
          return const SizedBox.shrink();
        }
    }
  }

  Widget _buildButton() {
    Widget button;

    switch (type) {
      case ButtonType.primary:
        button = ElevatedButton(
          onPressed: _isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _effectiveBackgroundColor,
            foregroundColor: _effectiveTextColor,
            elevation: _effectiveElevation,
            shadowColor: _effectiveBackgroundColor.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: _effectiveBorderRadius,
            ),
            padding: _effectivePadding,
            minimumSize: Size(
              fullWidth ? double.infinity : (width ?? 0),
              height ?? AppTheme.buttonHeightM,
            ),
          ),
          child: _buildContent(),
        );
      case ButtonType.secondary:
        button = ElevatedButton(
          onPressed: _isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _effectiveBackgroundColor,
            foregroundColor: _effectiveTextColor,
            elevation: _effectiveElevation,
            shadowColor: _effectiveBackgroundColor.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: _effectiveBorderRadius,
            ),
            padding: _effectivePadding,
            minimumSize: Size(
              fullWidth ? double.infinity : (width ?? 0),
              height ?? AppTheme.buttonHeightM,
            ),
          ),
          child: _buildContent(),
        );
      case ButtonType.outline:
        button = OutlinedButton(
          onPressed: _isEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            backgroundColor: _effectiveBackgroundColor,
            foregroundColor: _effectiveTextColor,
            side: BorderSide(color: _effectiveBorderColor),
            shape: RoundedRectangleBorder(
              borderRadius: _effectiveBorderRadius,
            ),
            padding: _effectivePadding,
            minimumSize: Size(
              fullWidth ? double.infinity : (width ?? 0),
              height ?? AppTheme.buttonHeightM,
            ),
          ),
          child: _buildContent(),
        );
      case ButtonType.text:
        button = TextButton(
          onPressed: _isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            backgroundColor: _effectiveBackgroundColor,
            foregroundColor: _effectiveTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: _effectiveBorderRadius,
            ),
            padding: _effectivePadding,
            minimumSize: Size(
              fullWidth ? double.infinity : (width ?? 0),
              height ?? AppTheme.buttonHeightS,
            ),
          ),
          child: _buildContent(),
        );
      case ButtonType.icon:
        button = IconButton(
          onPressed: _isEnabled ? onPressed : null,
          icon: _buildContent(),
          style: IconButton.styleFrom(
            backgroundColor: _effectiveBackgroundColor,
            foregroundColor: _effectiveTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: _effectiveBorderRadius,
            ),
            padding: _effectivePadding,
            minimumSize: Size(
              width ?? AppTheme.buttonHeightM,
              height ?? AppTheme.buttonHeightM,
            ),
          ),
        );
    }

    if (tooltip != null) {
      button = Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    if (margin != null) {
      button = Padding(
        padding: margin!,
        child: button,
      );
    }

    return button;
  }

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }
}

// Button group for multiple buttons
class CustomButtonGroup extends StatelessWidget {
  final List<CustomButton> buttons;
  final MainAxisAlignment alignment;
  final double spacing;
  final bool vertical;

  const CustomButtonGroup({
    super.key,
    required this.buttons,
    this.alignment = MainAxisAlignment.start,
    this.spacing = AppTheme.spacingM,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Column(
        mainAxisAlignment: alignment,
        children: buttons
            .map((button) => Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: button,
                ))
            .toList(),
      );
    }

    return Row(
      mainAxisAlignment: alignment,
      children: buttons
          .map((button) => Padding(
                padding: EdgeInsets.only(right: spacing),
                child: button,
              ))
          .toList(),
    );
  }
}

// Floating action button variant
class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;
  final bool isDisabled;

  const CustomFloatingActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (!isDisabled && !isLoading && onPressed != null) ? onPressed : null,
      backgroundColor: backgroundColor ?? AppTheme.primaryColor,
      foregroundColor: foregroundColor ?? AppTheme.surfaceColor,
      tooltip: tooltip,
      child: isLoading
          ? SizedBox(
              width: AppTheme.iconSizeM,
              height: AppTheme.iconSizeM,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? AppTheme.surfaceColor,
                ),
              ),
            )
          : Icon(icon),
    );
  }
}
