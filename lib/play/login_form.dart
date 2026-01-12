import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  final String? username;
  final String? password;
  final Uri? registerUrl;
  final bool enabled;
  final Function(String, String) onSubmit;

  const LoginForm(
      {super.key,
      this.username,
      this.password,
      this.registerUrl,
      required this.enabled,
      required this.onSubmit});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username ?? '';
    _passwordController.text = widget.password ?? '';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.0,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              enabled: widget.enabled,
              maxLength: 32,
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: loc.username,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username can not be empty';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              enabled: widget.enabled,
              maxLength: 32,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: loc.password,
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password can not be empty';
                }
                return null;
              },
            ),
            widget.enabled
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 8,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onSubmit(_usernameController.text,
                                  _passwordController.text);
                            }
                          },
                          child: Text(loc.login),
                        ),
                      ),
                      if (!Platform.isIOS &&
                          !Platform.isMacOS &&
                          widget.registerUrl != null)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _launchUrl(widget.registerUrl!),
                            child: Text(loc.register),
                          ),
                        ),
                    ],
                  )
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
