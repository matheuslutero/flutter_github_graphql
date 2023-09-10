import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    this.hintText = 'Search',
    this.onSubmitted,
    this.onClear,
  });

  final String hintText;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final controller = TextEditingController();

  void _onClear() {
    controller.clear();
    widget.onClear?.call();
  }

  void _onChanged(String _) {
    if (controller.text.isEmpty) {
      widget.onClear?.call();
    }
  }

  void _onSubmitted(String text) {
    widget.onSubmitted?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) => Container(
        constraints: const BoxConstraints(
          maxHeight: kToolbarHeight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: TextField(
          controller: controller,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          onChanged: _onChanged,
          onSubmitted: _onSubmitted,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _onClear,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
