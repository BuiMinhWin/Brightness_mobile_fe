import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DropdownOption {
  final String value;
  final String label;
  final dynamic data;

  const DropdownOption({required this.value, required this.label, this.data});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DropdownOption && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

class CustomDropdownField extends StatefulWidget {
  final String label;
  final String? value;
  final List<DropdownOption> options;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final String? hint;
  final Widget? prefixIcon;
  final bool enabled;
  final bool isExpanded;
  final String? helperText;
  final bool showSearch;
  final String? searchHint;

  const CustomDropdownField({
    super.key,
    required this.label,
    this.value,
    required this.options,
    this.onChanged,
    this.validator,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.isExpanded = true,
    this.helperText,
    this.showSearch = false,
    this.searchHint,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  bool _hasError = false;
  String? _errorText;
  String? _searchQuery;
  List<DropdownOption> _filteredOptions = [];

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
  }

  @override
  void didUpdateWidget(CustomDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options != oldWidget.options) {
      _filteredOptions = widget.options;
      _filterOptions();
    }
  }

  void _filterOptions() {
    if (widget.showSearch && _searchQuery != null && _searchQuery!.isNotEmpty) {
      _filteredOptions = widget.options
          .where(
            (option) => option.label.toLowerCase().contains(
              _searchQuery!.toLowerCase(),
            ),
          )
          .toList();
    } else {
      _filteredOptions = widget.options;
    }
  }

  void _validateField() {
    final error = widget.validator?.call(widget.value);
    setState(() {
      _hasError = error != null;
      _errorText = error;
    });
  }

  DropdownOption? _getSelectedOption() {
    if (widget.value == null) return null;
    try {
      return widget.options.firstWhere(
        (option) => option.value == widget.value,
      );
    } catch (e) {
      return null;
    }
  }

  Widget _buildDropdownItem(DropdownOption option) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      child: Text(
        option.label,
        style: AppTheme.textStyleBody1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSearchField() {
    if (!widget.showSearch) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: TextField(
        decoration: InputDecoration(
          hintText: widget.searchHint ?? 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM,
            vertical: AppTheme.spacingS,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
            _filterOptions();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedOption = _getSelectedOption();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          initialValue: widget.value,
          onChanged: widget.enabled
              ? (value) {
                  widget.onChanged?.call(value);
                  if (_hasError) {
                    _validateField();
                  }
                }
              : null,
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
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppTheme.textSecondary,
            ),
            isError: _hasError,
          ).copyWith(helperText: widget.helperText),
          isExpanded: widget.isExpanded,
          items: _filteredOptions.map((DropdownOption option) {
            return DropdownMenuItem<String>(
              value: option.value,
              child: _buildDropdownItem(option),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return _filteredOptions.map<Widget>((DropdownOption option) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  option.label,
                  style: AppTheme.textStyleBody1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          },
        ),
        if (_hasError && _errorText != null) ...[
          const SizedBox(height: AppTheme.spacingXS),
          Text(_errorText!, style: AppTheme.textStyleError),
        ],
      ],
    );
  }
}

// Alternative implementation with search functionality
class CustomDropdownFieldWithSearch extends StatefulWidget {
  final String label;
  final String? value;
  final List<DropdownOption> options;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final String? hint;
  final Widget? prefixIcon;
  final bool enabled;
  final String? helperText;
  final String? searchHint;

  const CustomDropdownFieldWithSearch({
    super.key,
    required this.label,
    this.value,
    required this.options,
    this.onChanged,
    this.validator,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.helperText,
    this.searchHint,
  });

  @override
  State<CustomDropdownFieldWithSearch> createState() =>
      _CustomDropdownFieldWithSearchState();
}

class _CustomDropdownFieldWithSearchState
    extends State<CustomDropdownFieldWithSearch> {
  bool _hasError = false;
  String? _errorText;
  bool _isOpen = false;
  String _searchQuery = '';
  List<DropdownOption> _filteredOptions = [];

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
  }

  void _filterOptions() {
    if (_searchQuery.isNotEmpty) {
      _filteredOptions = widget.options
          .where(
            (option) =>
                option.label.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    } else {
      _filteredOptions = widget.options;
    }
  }

  void _validateField() {
    final error = widget.validator?.call(widget.value);
    setState(() {
      _hasError = error != null;
      _errorText = error;
    });
  }

  DropdownOption? _getSelectedOption() {
    if (widget.value == null) return null;
    try {
      return widget.options.firstWhere(
        (option) => option.value == widget.value,
      );
    } catch (e) {
      return null;
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => _SearchDialog(
        options: widget.options,
        selectedValue: widget.value,
        onChanged: (value) {
          widget.onChanged?.call(value);
          Navigator.of(context).pop();
          if (_hasError) {
            _validateField();
          }
        },
        searchHint: widget.searchHint,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedOption = _getSelectedOption();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.enabled ? _showSearchDialog : null,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: Border.all(
                color: _hasError
                    ? AppTheme.borderErrorColor
                    : AppTheme.borderColor,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingM,
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  widget.prefixIcon!,
                  const SizedBox(width: AppTheme.spacingS),
                ],
                Expanded(
                  child: Text(
                    selectedOption?.label ?? widget.hint ?? widget.label,
                    style: selectedOption != null
                        ? AppTheme.textStyleBody1
                        : AppTheme.textStyleCaption,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_hasError && _errorText != null) ...[
          const SizedBox(height: AppTheme.spacingXS),
          Text(_errorText!, style: AppTheme.textStyleError),
        ],
      ],
    );
  }
}

class _SearchDialog extends StatefulWidget {
  final List<DropdownOption> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String? searchHint;

  const _SearchDialog({
    required this.options,
    this.selectedValue,
    required this.onChanged,
    this.searchHint,
  });

  @override
  State<_SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<_SearchDialog> {
  String _searchQuery = '';
  List<DropdownOption> _filteredOptions = [];

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
  }

  void _filterOptions() {
    if (_searchQuery.isNotEmpty) {
      _filteredOptions = widget.options
          .where(
            (option) =>
                option.label.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    } else {
      _filteredOptions = widget.options;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: widget.searchHint ?? 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _filterOptions();
                });
              },
            ),
            const SizedBox(height: AppTheme.spacingM),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredOptions.length,
                itemBuilder: (context, index) {
                  final option = _filteredOptions[index];
                  final isSelected = option.value == widget.selectedValue;

                  return ListTile(
                    title: Text(option.label),
                    selected: isSelected,
                    onTap: () => widget.onChanged(option.value),
                    trailing: isSelected ? const Icon(Icons.check) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
