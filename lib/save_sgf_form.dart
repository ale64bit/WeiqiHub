import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/wq/rank.dart';

class SaveSgfFormResult {
  final String? blackNick;
  final Rank? blackRank;
  final String? whiteNick;
  final Rank? whiteRank;
  final String? rules;
  final double? komi;
  final String? result;

  SaveSgfFormResult(
      {required this.blackNick,
      required this.blackRank,
      required this.whiteNick,
      required this.whiteRank,
      required this.rules,
      required this.komi,
      required this.result});

  String suggestedFilename() {
    final buf =
        StringBuffer(DateFormat('yyyy.MM.dd hh.mm').format(DateTime.now()));
    if (blackNick != null && whiteNick != null) {
      buf.write(' $blackNick vs $whiteNick');
    }
    buf.write('.sgf');
    return buf.toString();
  }
}

class SaveSgfForm extends StatefulWidget {
  const SaveSgfForm({super.key});

  @override
  State<SaveSgfForm> createState() => _SaveSgfFormState();
}

class _SaveSgfFormState extends State<SaveSgfForm> {
  final _formKey = GlobalKey<FormState>();
  final _blackNickController = TextEditingController();
  final _blackRankController = TextEditingController();
  final _whiteNickController = TextEditingController();
  final _whiteRankController = TextEditingController();
  final _rulesController = TextEditingController();
  final _komiController = TextEditingController();
  final _resultController = TextEditingController();

  Rank? blackRank = Rank.k5;
  Rank? whiteRank = Rank.k5;

  @override
  void dispose() {
    _blackNickController.dispose();
    _blackRankController.dispose();
    _whiteNickController.dispose();
    _whiteRankController.dispose();
    _rulesController.dispose();
    _komiController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _blackNickController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: loc.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<Rank>(
                    initialSelection: Rank.k5,
                    textAlign: TextAlign.center,
                    controller: _blackRankController,
                    requestFocusOnTap: true,
                    label: Text(loc.rank),
                    onSelected: (rank) {
                      setState(() {
                        blackRank = rank;
                      });
                    },
                    dropdownMenuEntries: Rank.values
                        .map((rank) => DropdownMenuEntry<Rank>(
                              value: rank,
                              label: rank.toString(),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _whiteNickController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: loc.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<Rank>(
                    initialSelection: Rank.k5,
                    textAlign: TextAlign.center,
                    controller: _whiteRankController,
                    requestFocusOnTap: true,
                    label: Text(loc.rank),
                    onSelected: (rank) {
                      setState(() {
                        whiteRank = rank;
                      });
                    },
                    dropdownMenuEntries: Rank.values
                        .map((rank) => DropdownMenuEntry<Rank>(
                              value: rank,
                              label: rank.toString(),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _rulesController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '${loc.rules} (e.g. chinese)',
              ),
            ),
            TextFormField(
              controller: _komiController,
              textAlign: TextAlign.center,
              validator: (value) {
                if (value != null) {
                  if (value.isNotEmpty && double.tryParse(value) == null) {
                    return 'Invalid komi value';
                  }
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '${loc.komi} (e.g. 6.5)',
              ),
            ),
            TextFormField(
              controller: _resultController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '${loc.result} (e.g. B+R)',
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(
                      context,
                      SaveSgfFormResult(
                        blackNick: _nullIfEmpty(_blackNickController.text),
                        blackRank: blackRank,
                        whiteNick: _nullIfEmpty(_whiteNickController.text),
                        whiteRank: whiteRank,
                        rules: _nullIfEmpty(_rulesController.text),
                        komi: double.tryParse(_komiController.text),
                        result: _nullIfEmpty(_resultController.text),
                      ));
                }
              },
              child: Text(loc.save),
            ),
          ],
        ),
      ),
    );
  }

  String? _nullIfEmpty(String? s) =>
      (s == null) ? null : (s.isEmpty ? null : s);
}
