import 'package:flutter/material.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator({
    super.key,
    this.indent = 16,
  });

  final double indent;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Divider(
        height: 1,
        indent: MediaQuery.paddingOf(context).left > 16 //
            ? indent - 16
            : indent,
      ),
    );
  }
}
