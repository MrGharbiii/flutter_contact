import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the home screen

class login_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  obscureText: true, // Hide the password text
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
              SizedBox(
                  height: 20), // Add spacing between text fields and button
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to HomeScreen on login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
