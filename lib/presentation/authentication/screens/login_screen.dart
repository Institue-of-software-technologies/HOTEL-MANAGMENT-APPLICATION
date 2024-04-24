// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/widgets/logo.dart';
import 'package:hotel/presentation/home/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
//define the logscreen widget, which extends statefulwidget
class LoginScreen extends StatefulWidget {
  //constructor for the loginsreen widget
  const LoginScreen({super.key});
  //create the state for the loginscreen widget
  @override
  State<LoginScreen> createState() => _CreateUserScreenState();
}
//define the _createUserscreenstate class which extends state<loginSreen>
class _CreateUserScreenState extends State<LoginScreen> {
  //initialize text editing ontollers for email and password feilds
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

//dispose of the text editing controllers when the user is disposed 
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
//buold he loginScreen widget
  @override
  Widget build(BuildContext context) {
    //return a scaffold widget containing the app bar, body and floating ation button
    return Scaffold(
      //set the app bar title to "login"
      appBar: AppBar(
        title: const Text('Login'),
      ),
      //add padding to the body of the scaffold widget
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        //return a column widget containing the logo, email and password text form fields and the login button
        child: Column(
          children: [
            //display the logo using the logowidget
            const LogoWidget(),
            //add a text form field to the email address
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefix:Icon(
                  Icons.email,
                  color: Colors.grey,
                )
              ),// put validation here for both login and register 
              validator: (value) {
                //failed validator
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
 
             ),
             //add veryical spacing between the email and password text form fields
            const SizedBox(height: 16),
            //add a text form field to the password
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefix:Icon(
                  Icons.lock,
                  color: Colors.grey,
                )
                //obscure the password text
              ),
              obscureText: true,
            ),
            //add a login button that calls the signInWithEmailAndPassword method when pressed
            ElevatedButton(
              onPressed: () async {
                //trim the email and password strings
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                // Pass the current context to the AuthProvider and calls the signInWithEmailAndPassword method
                await context
                    .read<AuthProvider>()
                    .signInWithEmailAndPassword(context, email, password);
                // Check if the user is created successfully
                if (context.read<AuthProvider>().user != null) {
                  //Navigate to the ProfileScreen widget
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                }
              },
              //set the text for the login buton
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
