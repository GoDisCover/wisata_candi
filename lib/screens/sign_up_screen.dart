import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_candi/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _fullnameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String _errorTextFullname = '';
  String _errorTextUsername = '';
  String _errorTextPassword = '';

  bool _isSignedIn = false;

  bool _obscurePassword = true;
  // TODO :  fungsi _signup
  void _signup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String fullname = _fullnameController.text.trim();
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    if (fullname.isEmpty) {
      setState(() {
        _errorTextFullname = ('Kolom ini Harus Diisi');
      });
    } else {
      setState(() {
        _errorTextFullname = '';
      });
    }
    if (username.isEmpty) {
      setState(() {
        _errorTextUsername = ('Kolom ini Harus Diisi');
      });
    } else {
      setState(() {
        _errorTextUsername = '';
      });
    }
    if (password.isEmpty) {
      setState(() {
        _errorTextPassword = ('Kolom ini Harus Diisi');
      });
    } else {
      if (password.length < 8 || !password.contains(RegExp(r'[A-z]'))) {
        setState(() {
          _errorTextPassword =
              'Minimal 8 karakter, kombinasi [A-Z], [a-z], [0-9], [!@#\\\$%^&*(),.?":{}|<>]';
        });
      } else {
        setState(() {
          _errorTextPassword = '';
        });
        return ;
      }
      prefs.setString('fullName', fullname);
      prefs.setString('username', username);
      prefs.setString('password', password);
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Pengguna',
                    border: OutlineInputBorder(),
                    errorText: _errorTextUsername.isNotEmpty
                        ? _errorTextUsername
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Panjang Pengguna',
                    border: OutlineInputBorder(),
                    errorText: _errorTextFullname.isNotEmpty
                        ? _errorTextFullname
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password Pengguna',
                    border: OutlineInputBorder(),
                    errorText: _errorTextPassword.isNotEmpty
                        ? _errorTextPassword
                        : null,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _signup();
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    text: 'Sudah Punya akun ?',
                    style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Masuk di sini',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (context) => SignInScreen(),
                            //   ),
                            // );
                            Navigator.pushNamed(context, '/signin');
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
