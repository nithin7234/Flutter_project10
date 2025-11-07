import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Secondscreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? errorMsg;
  Future<void> _login() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _email.text.trim())
          .limit(1)
          .get();
      if (snap.docs.isEmpty) {
        setState(() => errorMsg = "Invalid email or password");
        return;
      }
      final user = snap.docs.first.data();
      if (user['password'] == _password.text.trim()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SecondScreen(userName: user['name']),
          ),
        );
      } else {
        setState(() => errorMsg = "Invalid email or password");
      }
    } catch (e) {
      setState(() => errorMsg = "Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Login'),
        backgroundColor: const Color.fromARGB(255, 21, 110, 243),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
   Image.network('https://seeddownload.cdn-apple.com/s3/prod/ATLC/package/T050359A-en_US/6d75ff9c-3d23-4978-a6d6-291122a3c718/7.0/T050359A-ecc_p_design_an_app_icon-en_US/src/images/video_intro_video_poster.jpg',height: 150,width: 150,),
            SizedBox(height: 20),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _password,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                backgroundColor: const Color.fromARGB(255, 58, 255, 124)
              ),
              child: const Text('Login'),
            ),
            if (errorMsg != null) ...[
              const SizedBox(height: 10),
              Text(errorMsg!, style: const TextStyle(color: Colors.red)),
            ],],
        ),
      ),
    );
  }
}
