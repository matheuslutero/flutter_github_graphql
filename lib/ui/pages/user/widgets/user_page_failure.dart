import 'package:flutter/material.dart';

class UserPageFailure extends StatelessWidget {
  const UserPageFailure({
    super.key,
    required this.onReload,
  });

  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Uh-oh! Something went wrong.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            OutlinedButton(
              onPressed: onReload,
              child: const Text('Reload'),
            ),
            ElevatedButton(
              onPressed: onReload,
              child: const Text('Reload'),
            ),
          ],
        ),
      ),
    );
  }
}
