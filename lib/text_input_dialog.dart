import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class TextInputDialog extends StatefulWidget {
  final String title;
  final String content;
  final int? maxLength;

  const TextInputDialog({
    super.key,
    required this.title,
    required this.content,
    this.maxLength,
  });

  @override
  State<TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'text_input_dialog');
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.content,
          ),
          maxLength: widget.maxLength,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (value?.isEmpty ?? false) {
              return loc.errCannotBeEmpty;
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(loc.cancel),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, _controller.text);
            }
          },
          child: Text(loc.ok),
        ),
      ],
    );
  }
}
