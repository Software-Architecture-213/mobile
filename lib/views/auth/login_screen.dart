import 'package:flutter/material.dart';
import 'package:mobile/views/auth/register_screen.dart';

import '../../utils/validators/email_validator.dart';
import '../../utils/validators/password_validator.dart';


class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyWidget(),
    );
  }
}
class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  bool _showPassword = false;// Xem mật khẩu
  final TextEditingController _emailController = TextEditingController(); //Controller cho email
  final TextEditingController _passwordController = TextEditingController();//Controller cho password
  final _formKey = GlobalKey<FormState>();//Kiểm soát trạng thái của form
  late String _email, _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/2 - 60,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 20,
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/light-1.png')
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        left: 120,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/light-2.png')
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        top: 20,
                        width: 120,
                        height: 100,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/clock.png')
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0 ,10)
                                )]
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                _buildTextField(
                                    hintText: "Email",
                                    iconData: Icons.person,
                                    controller: _emailController,
                                    validator: EmailValidator.validate,
                                    onChanged: (value){
                                      setState(() {
                                        _email = value;
                                      });
                                    }
                                ),
                                _buildTextField(
                                  hintText: "Password",
                                  iconData: Icons.password_rounded,
                                  controller: _passwordController,
                                  validator: PasswordValidator.validate,
                                  obscureText: !_showPassword,
                                  onChanged: (value){
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                  suffixIcon: IconButton(
                                    color: Colors.grey[600],
                                    onPressed: (){
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    icon: _showPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              "Don\'t have an account ?",
                              style: TextStyle(
                                color:Color.fromRGBO(143, 148, 251, 1),
                              )
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Register()),
                              );
                            }, child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Color.fromRGBO(92, 96, 239, 1.0),
                                fontWeight: FontWeight.bold),
                          ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                          ),
                          onPressed: _login,
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
  Widget _buildTextField({
    required String hintText,
    required IconData iconData,
    Function (String)? onChanged,
    Widget? suffixIcon,
    bool obscureText = false,
    required TextEditingController controller,
    String? Function(String?) ? validator
  }){
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              color: Colors.grey[600],
              iconData,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                onChanged: onChanged,
                obscureText: obscureText,
                controller: controller,
                validator: validator,
              ),
            ),
            if(suffixIcon != null) suffixIcon
          ],
        )
    );
  }
  void _login() async{}
}
