import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final fakeEmail = '$username@nofood.com';

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請輸入帳號與密碼')),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: fakeEmail,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(username: username)),
      );
    } on FirebaseAuthException catch (e) {
      String msg = '登入失敗';
      if (e.code == 'user-not-found') {
        msg = '查無此帳號';
      } else if (e.code == 'wrong-password') {
        msg = '密碼錯誤';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "無食不歡",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 48),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: '帳號'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '密碼'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _login,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('登入'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
              child: const Text('還沒有帳號？去註冊'),
            ),
          ],
        ),
      ),
    );
  }
}
