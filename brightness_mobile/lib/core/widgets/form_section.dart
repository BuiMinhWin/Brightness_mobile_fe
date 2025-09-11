import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FormSection extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final bool showDivider;
  final Widget? header;
  final Widget? footer;
  final bool collapsible;
  final bool initiallyExpanded;
  final VoidCallback? onHeaderTap;
  final IconData? headerIcon;
  final Color? headerIconColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final double spacing;

  const FormSection({
    super.key,
    this.title,
    this.subtitle,
    required this.children,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.showBorder = true,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.showDivider = false,
    this.header,
    this.footer,
    this.collapsible = false,
    this.initiallyExpanded = true,
    this.onHeaderTap,
    this.headerIcon,
    this.headerIconColor,
    this.titleStyle,
    this.subtitleStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.spacing = AppTheme.spacingM,
  });

  @override
  Widget build(BuildContext context) {
    if (collapsible) {
      return _buildCollapsibleSection();
    }

    return _buildRegularSection();
  }

  Widget _buildRegularSection() {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: AppTheme.spacingL),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.surfaceColor,
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusL),
        border: showBorder
            ? Border.all(
                color: borderColor ?? AppTheme.borderColor,
                width: borderWidth,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (header != null || title != null) _buildHeader(),
          if (showDivider && (header != null || title != null))
            const Divider(height: 1, color: AppTheme.borderColor),
          Padding(
            padding: padding ?? const EdgeInsets.all(AppTheme.spacingL),
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: _buildChildrenWithSpacing(),
            ),
          ),
          if (footer != null) _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildCollapsibleSection() {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: AppTheme.spacingL),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.surfaceColor,
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusL),
        border: showBorder
            ? Border.all(
                color: borderColor ?? AppTheme.borderColor,
                width: borderWidth,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Builder(
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          onExpansionChanged: (expanded) {
            // Optional callback for expansion changes
          },
          title: _buildTitle(),
          subtitle: subtitle != null ? _buildSubtitle() : null,
          leading: headerIcon != null
              ? Icon(
                  headerIcon,
                  color: headerIconColor ?? AppTheme.primaryColor,
                )
              : null,
          children: [
            Padding(
              padding: padding ?? const EdgeInsets.all(AppTheme.spacingL),
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                children: _buildChildrenWithSpacing(),
              ),
            ),
            if (footer != null) _buildFooter(),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (header != null) return header!;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) _buildTitle(),
          if (subtitle != null) ...[
            const SizedBox(height: AppTheme.spacingXS),
            _buildSubtitle(),
          ],
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return GestureDetector(
      onTap: onHeaderTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title!,
              style: titleStyle ?? AppTheme.textStyleHeadline3,
            ),
          ),
          if (headerIcon != null)
            Icon(
              headerIcon,
              color: headerIconColor ?? AppTheme.primaryColor,
              size: AppTheme.iconSizeM,
            ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle!,
      style: subtitleStyle ?? AppTheme.textStyleBody2,
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.borderColor, width: 1),
        ),
      ),
      child: footer!,
    );
  }

  List<Widget> _buildChildrenWithSpacing() {
    if (children.isEmpty) return [];

    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(height: spacing));
      }
    }
    return spacedChildren;
  }
}

// Specialized form sections for common use cases
class FormSectionWithActions extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget> children;
  final List<Widget> actions;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool showBorder;
  final BorderRadius? borderRadius;
  final double spacing;

  const FormSectionWithActions({
    super.key,
    this.title,
    this.subtitle,
    required this.children,
    required this.actions,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.showBorder = true,
    this.borderRadius,
    this.spacing = AppTheme.spacingM,
  });

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: title,
      subtitle: subtitle,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      showBorder: showBorder,
      borderRadius: borderRadius,
      spacing: spacing,
      children: [
        ...children,
        const SizedBox(height: AppTheme.spacingL),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: actions
              .map((action) => Padding(
                    padding: const EdgeInsets.only(left: AppTheme.spacingS),
                    child: action,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class FormSectionWithIcon extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool showBorder;
  final BorderRadius? borderRadius;
  final double spacing;

  const FormSectionWithIcon({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    required this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.showBorder = true,
    this.borderRadius,
    this.spacing = AppTheme.spacingM,
  });

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: title,
      subtitle: subtitle,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      showBorder: showBorder,
      borderRadius: borderRadius,
      spacing: spacing,
      header: Container(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingS),
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppTheme.primaryColor,
                size: AppTheme.iconSizeM,
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.textStyleHeadline3,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      subtitle!,
                      style: AppTheme.textStyleBody2,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      children: children,
    );
  }
}

class FormSectionWithDivider extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double spacing;
  final Color? dividerColor;
  final double dividerThickness;

  const FormSectionWithDivider({
    super.key,
    this.title,
    this.subtitle,
    required this.children,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.spacing = AppTheme.spacingM,
    this.dividerColor,
    this.dividerThickness = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: title,
      subtitle: subtitle,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      showBorder: false,
      borderRadius: borderRadius,
      spacing: spacing,
      showDivider: true,
      children: children,
    );
  }
}

// Simple form section without borders or background
class SimpleFormSection extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  const SimpleFormSection({
    super.key,
    this.title,
    this.subtitle,
    required this.children,
    this.padding,
    this.margin,
    this.titleStyle,
    this.subtitleStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing = AppTheme.spacingM,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: AppTheme.spacingL),
      padding: padding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          if (title != null || subtitle != null) ...[
            if (title != null)
              Text(
                title!,
                style: titleStyle ?? AppTheme.textStyleHeadline3,
              ),
            if (subtitle != null) ...[
              const SizedBox(height: AppTheme.spacingXS),
              Text(
                subtitle!,
                style: subtitleStyle ?? AppTheme.textStyleBody2,
              ),
            ],
            const SizedBox(height: AppTheme.spacingL),
          ],
          ...children.expand((child) => [
                child,
                if (children.indexOf(child) < children.length - 1)
                  SizedBox(height: spacing),
              ]),
        ],
      ),
    );
  }
}
