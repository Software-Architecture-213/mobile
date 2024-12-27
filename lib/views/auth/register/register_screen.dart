import 'package:flutter/material.dart';
import 'package:mobile/views/auth/enums/gender.dart';
import 'package:mobile/views/auth/enums/role.dart';
import 'package:mobile/views/auth/otp_dialog.dart';
import 'package:mobile/views/auth/register/widgets/textformfield_register.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import '../../../utils/validators/confirm_password_validator.dart';
import '../../../utils/validators/email_validator.dart';
import '../../../utils/validators/password_validator.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../Login/login_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _registerState();
}

class _registerState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  DateTime? _selectedDate;
  late String _email, _password;
  final _formKey = GlobalKey<FormState>();
  String _role = Role.user;
  String _gender = Gender.male;
  void _createAccount(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        email: _emailController.text,
        password: _passwordController.text,
        displayName: _displayNameController.text,
        phoneNumber: _phoneNumberController.text,
        role: _role,
        gender: _gender,
      );

      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final response = await authViewModel.register(user);

      if (response.success) {
        // Handle successful registration
        showOtpDialog(context);
      } else {
        // Handle registration failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Đăng ký thất bại')),
        );
      }
    }
  }
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateOfBirthController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/icon_register_stock.png",
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
                      fontSize: 22, color: Color.fromRGBO(92, 96, 239, 1.0)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextFormField(
                          labelText: "Email",
                          iconData: Icons.email,
                          controller: _emailController,
                          validator: EmailValidator.validate,
                          onChanged: (value) {
                            _email = value;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      buildTextFormField(
                          labelText: "Password",
                          iconData: Icons.password,
                          controller: _passwordController,
                          validator: PasswordValidator.validate,
                          obscureText: true,
                          onChanged: (value) {
                            _password = value;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      buildTextFormField(
                          labelText: "Confirm Password",
                          iconData: Icons.password_rounded,
                          validator: (value) =>
                              ConfirmPasswordValidator.validate(
                                  value, _passwordController.text),
                          obscureText: true,
                          controller: _confirmPasswordController),
                      const SizedBox(
                        height: 15,
                      ),
                      buildTextFormField(
                        labelText: "Display Name",
                        iconData: Icons.person,
                        controller: _displayNameController,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your display name'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      buildTextFormField(
                        labelText: "Phone Number",
                        iconData: Icons.phone,
                        controller: _phoneNumberController,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your phone number'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      buildTextFormField(
                        labelText: "Date of Birth",
                        iconData: Icons.calendar_today,
                        controller: _dateOfBirthController,
                        validator: (value) => value!.isEmpty ? 'Please select your date of birth' : null,
                        onTap: () {
                          _selectDate(context);
                        },
                        readOnly: true,
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: "Role",contentPadding: EdgeInsets.zero),
                        items: [
                          DropdownMenuItem(
                              value: Role.user, child: Text(Role.user)),
                          DropdownMenuItem(
                              value: Role.admin, child: Text(Role.admin)),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _role = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: "Gender",contentPadding: EdgeInsets.zero),
                        items: [
                          DropdownMenuItem(
                              value: Gender.male, child: Text(Gender.male)),
                          DropdownMenuItem(
                              value: Gender.female,
                              child: Text(Gender.female)),
                          DropdownMenuItem(
                              value: Gender.other, child: Text(Gender.other)),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
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
                            onPressed: () {
                              _createAccount(context);
                            },
                            child: const Text("Create Account",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already a User?",
                              style: TextStyle(
                                color: Color.fromRGBO(62, 81, 211, 1.0),
                                fontSize: 18,
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: const Text(
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
            )),
      ),
    );
  }
}
