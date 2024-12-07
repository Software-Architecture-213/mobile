import 'package:flutter/material.dart';

import '../../utils/validators/confirm_password_validator.dart';
import '../../utils/validators/email_validator.dart';
import '../../utils/validators/password_validator.dart';
import 'login_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _registerState();
}
class _registerState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late String _email, _password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  "assets/icon_register_stock.png",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome back!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(92, 96, 239, 1.0)),
                ),
                const Text(
                  "Let's Create Your Account",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(92, 96, 239, 1.0)),
                ),
                const SizedBox(
                  height: 70,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                          labelText: "Email",
                          iconData: Icons.email,
                          controller: _emailController,
                          validator: EmailValidator.validate,
                          onChanged: (value){
                            _email = value;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextField(
                          labelText: "Password",
                          iconData: Icons.password,
                          controller: _passwordController,
                          validator: PasswordValidator.validate,
                          obscureText: true,
                          onChanged: (value){
                            _password = value;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextField(
                          labelText: "Confirm Password",
                          iconData: Icons.password_rounded,
                          validator:(value)=> ConfirmPasswordValidator.validate(value, _passwordController.text),
                          obscureText: true,
                          controller: _confirmPasswordController),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                            ),
                            onPressed:() => _register(),
                            child: const Text("Create Account",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              "Already a User?",
                              style: TextStyle(
                                color:Color.fromRGBO(62, 81, 211, 1.0),
                                fontSize: 18,
                              )
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            }, child: const Text(
                            "Login now",
                            style: TextStyle(
                                color: Color.fromRGBO(33, 39, 225, 1.0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
  Widget _buildTextField(
      {required String labelText,
        required IconData iconData,
        required TextEditingController controller,
        String? Function(String?)? validator,
        bool obscureText = false,
        Function (String)? onChanged,}) {
    return TextFormField(
      expands: false,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            iconData,
            size: 30,
            color: const Color.fromRGBO(143, 148, 251, 1),
          ),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
  void _register() async {
  }
}
