import 'package:flutter/material.dart';

class MyInputValidation extends StatefulWidget {
  const MyInputValidation({Key? key});

  @override
  State<MyInputValidation> createState() => _MyInputValidationState();
}

class _MyInputValidationState extends State<MyInputValidation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerName.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

// validasi nama
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name must not be empty';
    }

    final nameSplit = value.split(' ');

    if (nameSplit.length < 2) {
      return 'Name must consist of at least 2 words';
    }

    for (String word in nameSplit) {
      if (!RegExp(r"^[A-Z][a-z]*$").hasMatch(word)) {
        return 'Each word must start with a capital letter and not contain numbers or special characters';
      }
    }

    return null;
  }

// validasi phone number
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number must not be empty';
    }

    if (!RegExp(r'^0[0-9]{7,12}$').hasMatch(value)) {
      return 'Phone number must start with the digit 0, consist of digits, and have a length of 8-13 digits';
    }

    return null;
  }

// validasi tanggal
  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date must not be empty';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UTS',
          style: TextStyle(color: Colors.black), // Set text color to black
        ),
        backgroundColor: const Color.fromARGB(
            255, 220, 226, 213), // Set background color to blue
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _controllerPhoneNumber,
                validator: _validatePhoneNumber,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Color.fromARGB(255, 158, 216, 143),
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerName,
                validator: _validateName,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Color.fromARGB(255, 158, 216, 143),
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controllerDate,
                      validator: _validateDate,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: 'Select a date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fillColor: Color.fromARGB(255, 158, 216, 143),
                        filled: true,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          _controllerDate.text =
                              pickedDate.toLocal().toString().split(' ')[0];
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Processing Data"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Hello, ${_controllerName.text}'),
                              Text(
                                  'Phone Number: ${_controllerPhoneNumber.text}'),
                              Text('Date: ${_controllerDate.text}'),
                              // Add color and file information here
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please complete the form correctly"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
