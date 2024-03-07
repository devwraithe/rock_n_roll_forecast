import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: Center(
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: AppTextTheme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
