import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../Login/widgets/dropdown.dart';

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
        phoneNumber: getFullPhoneNumber(),
        dateOfBirth: _selectedDate,
        role: _role,
        gender: _gender,
      );

      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final response = await authViewModel.register(user);

      if (response.success) {
        _generateOtp(context, authViewModel);
      } else {
        // Handle registration failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Đăng ký thất bại')),
        );
      }
    }
  }
  // Hàm lấy số điện thoại đầy đủ (thêm +84 vào đầu)
  String getFullPhoneNumber() {
    final rawNumber = _phoneNumberController.text.trim();
    return '+84$rawNumber'; // Tự động thêm +84
  }
  // Hàm kiểm tra số điện thoại
  String? validatePhoneNumber(String value) {
    final regex = RegExp(r'^\d{9}$'); // Số điện thoại phải có 9 chữ số không kể dấu +84
    if (!regex.hasMatch(value)) {
      return 'Số điện thoại phải có đúng 9 chữ số.';
    }
    return null;
  }
  void _generateOtp(BuildContext context, AuthViewModel authViewModel) async {
    final response = await authViewModel.generateOtp(_emailController.text);
    if (response.success) {
      showOtpDialog(context, _emailController.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message ?? 'OTP generation failed')),
      );
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
    final authViewModel = Provider.of<AuthViewModel>(context);
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
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // Chỉ cho phép số
                          ],
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            contentPadding: EdgeInsets.zero,
                            prefixText: '+84 ',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return validatePhoneNumber(value);
                          },
                        ),
                      ),

                      const SizedBox(height: 15),
                      EnumDropdownButtonFormField<String>(
                        labelText: "Role",
                        value: _role,
                        items: [Role.user, Role.admin, Role.branch],
                        onChanged: (value) {
                          setState(() {
                            _role = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      EnumDropdownButtonFormField<String>(
                        labelText: "Gender",
                        value: _gender,
                        items: [Gender.male, Gender.female, Gender.other],
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
                            child: authViewModel.isLoadingRegister
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                :
                            const Text("Create Account",
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
