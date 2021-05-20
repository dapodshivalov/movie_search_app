import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  bool shouldIncludeReview = false;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState(){
    Future.delayed(Duration.zero,(){
      setState(() {
        final settings = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        widget.shouldIncludeReview = settings['shouldIncludeReview'];
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Использовать рецензии для поиска"),
                  Switch(value: widget.shouldIncludeReview, onChanged: _onChanged),
                ],
              ),
            ),
            _buildDividerLine(),
          ],
        ),
      ),
    );
  }

  _onChanged(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('shouldIncludeReview', newValue);
    setState(() {
      widget.shouldIncludeReview = newValue;
    });
  }

  Widget _buildDividerLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Divider(),
    );
  }
}
