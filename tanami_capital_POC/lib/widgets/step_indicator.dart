import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int stepNumber;
  final String title;
  final String description;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.stepNumber,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = stepNumber - 1 <= currentStep;
    final bool isCurrent = stepNumber - 1 == currentStep;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle indicator with step number
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive 
                ? Colors.white 
                : Colors.white.withOpacity(0.3),
            border: Border.all(
              color: isCurrent 
                  ? Colors.white 
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              stepNumber.toString(),
              style: TextStyle(
                color: isActive 
                    ? AppColors.primaryGreen 
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // Step title and description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.stepHeading.copyWith(
                  color: isActive 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTextStyles.stepDescription.copyWith(
                  color: isActive 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}