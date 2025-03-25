import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/step_indicator.dart';
import '../assets/tanami_logo.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  
  int _currentStep = 0;
  
  // Step 1 controllers
  final _countryController = TextEditingController();
  final _mobileController = TextEditingController();
  
  // Step 2 controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  
  // Step 3 controllers
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _pinController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _obscurePin = true;

  @override
  void dispose() {
    _countryController.dispose();
    _mobileController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _togglePinVisibility() {
    setState(() {
      _obscurePin = !_obscurePin;
    });
  }

  void _nextStep() {
    if (_formKeys[_currentStep].currentState!.validate()) {
      if (_currentStep < 2) {
        setState(() {
          _currentStep++;
        });
      } else {
        // Final step - registration would be completed here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! You can now log in.'),
            backgroundColor: AppColors.successGreen,
          ),
        );
        Navigator.pop(context); // Return to login screen
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context); // Go back to login screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar with back button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: _previousStep,
                    ),
                    const Expanded(
                      child: Center(
                        child: TanamiLogo(height: 30),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the layout
                  ],
                ),
              ),
              
              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Registration steps section with dark green background
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Step indicators
                            StepIndicator(
                              currentStep: _currentStep,
                              stepNumber: 1, 
                              title: 'Step 1',
                              description: 'Enter your country of residence and mobile number',
                            ),
                            const SizedBox(height: 16),
                            StepIndicator(
                              currentStep: _currentStep,
                              stepNumber: 2, 
                              title: 'Step 2',
                              description: 'Enter your name and email',
                            ),
                            const SizedBox(height: 16),
                            StepIndicator(
                              currentStep: _currentStep,
                              stepNumber: 3, 
                              title: 'Step 3',
                              description: 'Set a password and unique pin code',
                            ),
                          ],
                        ),
                      ),
                      
                      // Form content based on current step
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: _buildCurrentStepForm(),
                          ),
                        ),
                      ),
                      
                      // Tagline
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTextStyles.tagline,
                            children: [
                              TextSpan(text: 'Start Investing in '),
                              TextSpan(
                                text: 'Under 10 minutes',
                                style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Next/Sign up button
                      CustomButton(
                        label: _currentStep < 2 ? 'Next' : 'Sign up',
                        onPressed: _nextStep,
                        type: ButtonType.filled,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStepForm() {
    switch (_currentStep) {
      case 0:
        return _buildStep1Form();
      case 1:
        return _buildStep2Form();
      case 2:
        return _buildStep3Form();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1Form() {
    return Form(
      key: _formKeys[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: _countryController,
            label: 'Country of Residence',
            hintText: 'Select your country',
            suffixIcon: const Icon(Icons.arrow_drop_down, color: AppColors.mediumText),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your country of residence';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _mobileController,
            label: 'Mobile Number',
            hintText: 'Enter your mobile number',
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              if (value.length < 10) {
                return 'Please enter a valid mobile number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Form() {
    return Form(
      key: _formKeys[1],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: _nameController,
            label: 'Full Name',
            hintText: 'Enter your full name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _emailController,
            label: 'Email Address',
            hintText: 'Enter your email address',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStep3Form() {
    return Form(
      key: _formKeys[2],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Create a password',
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.mediumText,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hintText: 'Confirm your password',
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.mediumText,
              ),
              onPressed: _toggleConfirmPasswordVisibility,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _pinController,
            label: 'PIN Code',
            hintText: 'Create a 4-digit PIN',
            obscureText: _obscurePin,
            keyboardType: TextInputType.number,
            maxLength: 4,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePin ? Icons.visibility_off : Icons.visibility,
                color: AppColors.mediumText,
              ),
              onPressed: _togglePinVisibility,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a PIN code';
              }
              if (value.length != 4) {
                return 'PIN must be 4 digits';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}