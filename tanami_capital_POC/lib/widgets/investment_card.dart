import 'package:flutter/material.dart';
import '../models/investment_opportunity.dart';
import '../theme/colors.dart';
import 'package:intl/intl.dart';

class InvestmentCard extends StatelessWidget {
  final InvestmentOpportunity investment;
  final VoidCallback onTap;

  const InvestmentCard({
    Key? key,
    required this.investment,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category label with colored background
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    investment.category,
                    style: const TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      investment.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Main content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Investment name
                  Text(
                    investment.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Description
                  Text(
                    investment.description,
                    style: const TextStyle(
                      color: AppColors.mediumText,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  
                  // Investment details
                  Row(
                    children: [
                      _buildDetailItem('Min. Investment', '\$${NumberFormat('#,###').format(investment.minimumInvestment)}'),
                      const SizedBox(width: 16),
                      _buildDetailItem('Target Return', '${investment.targetReturn}%'),
                      const SizedBox(width: 16),
                      _buildDetailItem('Duration', investment.duration),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Funding Progress: ${investment.fundingPercentage.toInt()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.mediumText,
                            ),
                          ),
                          Text(
                            '\$${NumberFormat('#,###').format(investment.currentFunding)} / \$${NumberFormat('#,###').format(investment.fundingGoal)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.mediumText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: investment.fundingPercentage / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                          minHeight: 8,
                        ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Closing date
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppColors.mediumText,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Closing: ${DateFormat('MMM dd, yyyy').format(investment.closingDate)}',
                        style: const TextStyle(
                          color: AppColors.mediumText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],),
           )
        ],),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.mediumText,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.darkText,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}