import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String? _verificationId;
  bool _codeSent = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone (+62...)')),
            SizedBox(height: 12),
            ElevatedButton(
                onPressed: () async {
                  final phone = _phoneController.text.trim();
                  await auth.verifyPhone(
                      phone: phone,
                      codeSent: (vid) {
                        setState(() {
                          _verificationId = vid;
                          _codeSent = true;
                        });
                      },
                      onFailed: (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification failed: ${e.message}')));
                      });
                },
                child: Text('Send code')),
            if (_codeSent) ...[
              TextField(controller: _codeController, decoration: InputDecoration(labelText: 'SMS Code')),
              SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () async {
                    final code = _codeController.text.trim();
                    await auth.signInWithSms(verificationId: _verificationId!, smsCode: code);
                  },
                  child: Text('Verify & Sign in'))
            ]
          ],
        ),
      ),
    );
  }
}
