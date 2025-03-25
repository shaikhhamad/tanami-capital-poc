import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/investment_opportunity.dart';
import '../services/investment_service.dart';
import '../theme/colors.dart';
import '../widgets/investment_card.dart';
import '../assets/tanami_logo.dart';
import '../widgets/custom_button.dart';

class FeatureScreen extends StatefulWidget {
  const FeatureScreen({super.key});

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends State<FeatureScreen> {
  final InvestmentService _investmentService = InvestmentService();
  bool _isLoading = true;
  List<InvestmentOpportunity> _investments = [];
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Infrastructure', 'Renewable Energy', 'Technology', 'Real Estate', 'Healthcare'];
  
  @override
  void initState() {
    super.initState();
    _loadInvestments();
  }
  
  Future<void> _loadInvestments() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final investments = await _investmentService.getInvestmentOpportunities();
      setState(() {
        _investments = investments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading investments: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
  List<InvestmentOpportunity> get _filteredInvestments {
    if (_selectedFilter == 'All') {
      return _investments;
    } else {
      return _investments.where((investment) => investment.category == _selectedFilter).toList();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightGrey,
      appBar: AppBar(
        title: const Text('Investment Opportunities'),
        centerTitle: true,
        backgroundColor: AppColors.lightGreen,
        foregroundColor: AppColors.darkText,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Column(
        children: [
          // Category filters
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filterOptions.length,
              itemBuilder: (context, index) {
                final option = _filterOptions[index];
                final isSelected = option == _selectedFilter;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = option;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryGreen : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.primaryGreen : AppColors.lightGrey,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.mediumText,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Investment listings
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primaryGreen),
                  )
                : _filteredInvestments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off,
                              color: AppColors.mediumText,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No investments found',
                              style: TextStyle(
                                color: AppColors.mediumText,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 24),
                            CustomButton(
                              label: 'Reset Filters',
                              onPressed: () {
                                setState(() {
                                  _selectedFilter = 'All';
                                });
                              },
                              type: ButtonType.outlined,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadInvestments,
                        color: AppColors.primaryGreen,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8, bottom: 24),
                          itemCount: _filteredInvestments.length,
                          itemBuilder: (context, index) {
                            final investment = _filteredInvestments[index];
                            return InvestmentCard(
                              investment: investment,
                              onTap: () {
                                _showInvestmentDetails(investment);
                              },
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
  
  void _showInvestmentDetails(InvestmentOpportunity investment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (_, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Handle
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  
                  // Content
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(24),
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.business,
                                color: AppColors.primaryGreen,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    investment.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkText,
                                    ),
                                  ),
                                  Text(
                                    investment.category,
                                    style: const TextStyle(
                                      color: AppColors.mediumText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Description
                        const Text(
                          'About this investment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          investment.description,
                          style: const TextStyle(
                            color: AppColors.mediumText,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Key details
                        const Text(
                          'Key Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow('Minimum Investment', '\$${investment.minimumInvestment.toStringAsFixed(0)}'),
                        const Divider(height: 24),
                        _buildDetailRow('Target Return', '${investment.targetReturn}%'),
                        const Divider(height: 24),
                        _buildDetailRow('Risk Level', investment.riskLevel),
                        const Divider(height: 24),
                        _buildDetailRow('Duration', investment.duration),
                        const Divider(height: 24),
                        _buildDetailRow('Closing Date', '${investment.closingDate.day}/${investment.closingDate.month}/${investment.closingDate.year}'),
                        const SizedBox(height: 24),
                        
                        // Funding progress
                        const Text(
                          'Funding Progress',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: investment.fundingPercentage / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                          minHeight: 8,
                        ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${investment.currentFunding.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${investment.fundingGoal.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: AppColors.mediumText,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${investment.fundingPercentage.toStringAsFixed(1)}% funded',
                          style: const TextStyle(
                            color: AppColors.mediumText,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Action buttons
                        CustomButton(
                          label: 'Invest Now',
                          onPressed: () {
                            Navigator.pop(context);
                            // In a real app, this would navigate to an investment flow
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Investment functionality would be implemented here'),
                                backgroundColor: AppColors.primaryGreen,
                              ),
                            );
                          },
                          type: ButtonType.filled,
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          label: 'Save for Later',
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Investment saved for later'),
                                backgroundColor: AppColors.secondaryGreen,
                              ),
                            );
                          },
                          type: ButtonType.outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.mediumText,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.darkText,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}