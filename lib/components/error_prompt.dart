import 'package:flutter/material.dart';

/// Custom error prompt widget with retry button
class ErrorPrompt extends StatelessWidget {
  const ErrorPrompt({
    super.key,
    required this.message,
    this.onRetry,
  });
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(
            message,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
