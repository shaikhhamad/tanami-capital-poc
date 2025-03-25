import 'package:flutter/material.dart';
import '../theme/colors.dart';

class TanamiLogo extends StatelessWidget {
  final double height;
  
  const TanamiLogo({
    super.key,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 8),
        
        // Text part of the logo
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanami',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: height * 0.5,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'CAPITAL',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: height * 0.25,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

