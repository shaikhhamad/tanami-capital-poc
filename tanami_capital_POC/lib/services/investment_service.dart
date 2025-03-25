import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/investment_opportunity.dart';

class InvestmentService {
  // Simulates fetching data from an API
  Future<List<InvestmentOpportunity>> getInvestmentOpportunities() async {
    // This simulates network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real app, this would be an API call
    // return await http.get('https://api.example.com/investments');
    
    // For now, we return the sample data
    return sampleInvestmentOpportunities;
  }
  
  // Method to fetch a specific investment opportunity by ID
  Future<InvestmentOpportunity?> getInvestmentOpportunityById(String id) async {
    final opportunities = await getInvestmentOpportunities();
    try {
      return opportunities.firstWhere((opportunity) => opportunity.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Simulates an API call to invest in an opportunity
  Future<bool> investInOpportunity(String opportunityId, double amount) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real app, this would be an API call
    // return await http.post('https://api.example.com/investments/$opportunityId/invest', 
    //   body: {'amount': amount});
    
    // For demo, always return success
    return true;
  }
}