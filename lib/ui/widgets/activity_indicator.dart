import 'package:flutter/material.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
