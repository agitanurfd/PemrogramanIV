import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  const MyInput({Key? key}) : super(key: key);

  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  String _name = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool lightOn = false;
  String language = '';
  bool agree = false;
  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected language: $language'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Write your name here...',
                  labelText: 'Your Name',
                ),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Hello, $_name'),
                        );
                      },
                    );
                  }
                },
              ),
              Switch(
                value: lightOn,
                onChanged: (bool value) {
                  setState(() {
                    lightOn = value;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(lightOn ? 'Light On' : 'Light Off'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Radio<String>(
                      value: 'Dart',
                      groupValue: language,
                      onChanged: (String? value) {
                        setState(() {
                          language = value!;
                          showSnackbar();
                        });
                      },
                    ),
                    title: const Text('Dart'),
                  ),
                  ListTile(
                    leading: Radio<String>(
                      value: 'Kotlin',
                      groupValue: language,
                      onChanged: (String? value) {
                        setState(() {
                          language = value!;
                          showSnackbar();
                        });
                      },
                    ),
                    title: const Text('Kotlin'),
                  ),
                  ListTile(
                    leading: Radio<String>(
                      value: 'Swift',
                      groupValue: language,
                      onChanged: (String? value) {
                        setState(() {
                          language = value!;
                          showSnackbar();
                        });
                      },
                    ),
                    title: const Text('Swift'),
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: agree,
                      onChanged: (bool? value) {
                        setState(() {
                          agree = value!;
                        });
                      },
                    ),
                    title: const Text('Agree / Disagree'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
