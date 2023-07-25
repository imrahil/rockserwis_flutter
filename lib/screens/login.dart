import 'package:flutter/material.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/models/form_data.dart';
import 'package:music_player/screens/podcasts.dart';

class LoginPage extends StatefulWidget {
  final API apiProvider;

  const LoginPage({super.key, required this.apiProvider});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FormData formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in Form'),
      ),
      body: Form(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...[
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Your email address',
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      formData.email = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      formData.password = value;
                    },
                  ),
                  TextButton(
                      child: const Text('Sign in'),
                      onPressed: () async {
                        bool result = await widget.apiProvider.login(formData);

                        if (result && mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PodcastsPage(apiProvider: widget.apiProvider)),
                          );
                        } else {
                          _showDialog('Unable to sign in.');
                        }
                      }
                  ),
                ].expand(
                  (widget) => [
                    widget,
                    const SizedBox(
                      height: 24,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
