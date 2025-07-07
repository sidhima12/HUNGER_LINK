import 'package:flutter/material.dart';
import 'ngo_home.dart';
import 'donor_home.dart';
import 'admin_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'NGO'; // Default role

  // Remember to dispose of controllers to free up resources
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async { // Made async for potential future API calls
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // 1. Basic Input Validation
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password.')),
      );
      return; // Stop if validation fails
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    // You might show a loading indicator here (e.g., a CircularProgressIndicator)
    // before making an API call.

    try {
      // 2. Simulated Authentication (Replace with actual API call)
      // In a real app, you'd call an authentication service:
      // bool isAuthenticated = await AuthService.login(email, password, _selectedRole);

      // --- DEMO AUTHENTICATION LOGIC ---
      bool isAuthenticated = false;
      if (_selectedRole == 'NGO' && email == 'ngo@example.com' && password == 'ngo123') {
        isAuthenticated = true;
      } else if (_selectedRole == 'Donor' && email == 'donor@example.com' && password == 'donor123') {
        isAuthenticated = true;
      } else if (_selectedRole == 'Admin' && email == 'admin@example.com' && password == 'admin123') {
        isAuthenticated = true;
      }
      // --- END DEMO AUTHENTICATION LOGIC ---

      if (isAuthenticated) {
        // 3. Navigate to the appropriate screen
        Widget targetScreen;
        if (_selectedRole == 'NGO') {
          targetScreen = const NgoHome();
        } else if (_selectedRole == 'Donor') {
          targetScreen = const DonorHome();
        } else { // Admin
          targetScreen = const AdminHome();
        }

        // Use pushReplacement to prevent going back to login screen with back button
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => targetScreen),
        );
      } else {
        // Show error if authentication fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials or role. Please try again.')),
        );
      }
    } catch (e) {
      // 4. Robust Error Handling (e.g., network issues)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center( // Center the content on the screen
        child: SingleChildScrollView( // Allow scrolling if content overflows
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(), // Add a border
                  prefixIcon: Icon(Icons.email), // Add an icon
                ),
                keyboardType: TextInputType.emailAddress, // Set keyboard type
                textInputAction: TextInputAction.next, // Move to next field
                autofillHints: const [AutofillHints.email],
              ),
              const SizedBox(height: 16), // Increased spacing
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(), // Add a border
                  prefixIcon: Icon(Icons.lock), // Add an icon
                ),
                obscureText: true, // Hide password
                textInputAction: TextInputAction.done, // "Done" button for last field
                autofillHints: const [AutofillHints.password],
                onSubmitted: (_) => _handleLogin(), // Trigger login on "done"
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>( // Use DropdownButtonFormField for better integration with forms
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Select Role',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                items: ['NGO', 'Donor', 'Admin']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32), // Increased spacing
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16), // Larger button
                  textStyle: const TextStyle(fontSize: 18), // Larger text
                ),
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}