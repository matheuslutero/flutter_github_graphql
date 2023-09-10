import 'package:app/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserPageLoading extends StatelessWidget {
  const UserPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const ActivityIndicator(),
    );
  }
}
