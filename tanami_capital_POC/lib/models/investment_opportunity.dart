class InvestmentOpportunity {
  final String id;
  final String name;
  final String description;
  final String category;
  final double minimumInvestment;
  final double targetReturn;
  final String riskLevel;
  final String duration;
  final DateTime closingDate;
  final String status;
  final double currentFunding;
  final double fundingGoal;
  final double fundingPercentage;

  InvestmentOpportunity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.minimumInvestment,
    required this.targetReturn,
    required this.riskLevel,
    required this.duration,
    required this.closingDate,
    required this.status,
    required this.currentFunding,
    required this.fundingGoal,
    required this.fundingPercentage,
  });

  factory InvestmentOpportunity.fromJson(Map<String, dynamic> json) {
    return InvestmentOpportunity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      minimumInvestment: json['minimumInvestment'].toDouble(),
      targetReturn: json['targetReturn'].toDouble(),
      riskLevel: json['riskLevel'],
      duration: json['duration'],
      closingDate: DateTime.parse(json['closingDate']),
      status: json['status'],
      currentFunding: json['currentFunding'].toDouble(),
      fundingGoal: json['fundingGoal'].toDouble(),
      fundingPercentage: json['fundingPercentage'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'minimumInvestment': minimumInvestment,
      'targetReturn': targetReturn,
      'riskLevel': riskLevel,
      'duration': duration,
      'closingDate': closingDate.toIso8601String(),
      'status': status,
      'currentFunding': currentFunding,
      'fundingGoal': fundingGoal,
      'fundingPercentage': fundingPercentage,
    };
  }
}

// Sample data for demonstration purposes
List<InvestmentOpportunity> sampleInvestmentOpportunities = [
  InvestmentOpportunity(
    id: '1',
    name: 'Infrastructure Fund IV',
    description: 'Investment in critical infrastructure projects across developing markets in Asia and Africa.',
    category: 'Infrastructure',
    minimumInvestment: 10000,
    targetReturn: 11.5,
    riskLevel: 'Moderate',
    duration: '5 years',
    closingDate: DateTime(2024, 6, 20),
    status: 'Open',
    currentFunding: 8500000,
    fundingGoal: 10000000,
    fundingPercentage: 85,
  ),
  InvestmentOpportunity(
    id: '2',
    name: 'Renewable Energy Fund',
    description: 'Investment in solar and wind energy projects with long-term power purchase agreements.',
    category: 'Renewable Energy',
    minimumInvestment: 5000,
    targetReturn: 9.2,
    riskLevel: 'Low',
    duration: '7 years',
    closingDate: DateTime(2024, 8, 15),
    status: 'Open',
    currentFunding: 12500000,
    fundingGoal: 25000000,
    fundingPercentage: 50,
  ),
  InvestmentOpportunity(
    id: '3',
    name: 'Tech Growth Fund II',
    description: 'Investment in late-stage technology companies with proven business models and strong growth.',
    category: 'Technology',
    minimumInvestment: 25000,
    targetReturn: 18.7,
    riskLevel: 'High',
    duration: '4 years',
    closingDate: DateTime(2024, 5, 30),
    status: 'Open',
    currentFunding: 35000000,
    fundingGoal: 50000000,
    fundingPercentage: 70,
  ),
  InvestmentOpportunity(
    id: '4',
    name: 'Real Estate Development Fund',
    description: 'Investment in commercial real estate development projects in major metropolitan areas.',
    category: 'Real Estate',
    minimumInvestment: 15000,
    targetReturn: 12.3,
    riskLevel: 'Moderate',
    duration: '6 years',
    closingDate: DateTime(2024, 7, 10),
    status: 'Open',
    currentFunding: 18000000,
    fundingGoal: 30000000,
    fundingPercentage: 60,
  ),
  InvestmentOpportunity(
    id: '5',
    name: 'Healthcare Innovation Fund',
    description: 'Investment in healthcare startups focused on medical technology and digital health solutions.',
    category: 'Healthcare',
    minimumInvestment: 20000,
    targetReturn: 16.5,
    riskLevel: 'High',
    duration: '5 years',
    closingDate: DateTime(2024, 9, 5),
    status: 'Open',
    currentFunding: 9000000,
    fundingGoal: 20000000,
    fundingPercentage: 45,
  ),
];