import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  Color _currentColor = const Color.fromARGB(255, 72, 159, 199);
  String? _dataFile;
  final List<Map<String, dynamic>> _myDataList = [];
  int? _editIndex;

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';
    for (String part in nameParts) {
      initials += part[0].toUpperCase();
    }
    return initials;
  }

// format untuk tanggal
  String _formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerName.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

// tambah data
  void _addData() {
    final data = {
      'phoneNumber': _controllerPhoneNumber.text,
      'name': _controllerName.text,
      'date': _controllerDate.text,
      'color': _currentColor,
      'file': _dataFile,
    };
    setState(() {
      _myDataList.add(data);
      _controllerPhoneNumber.clear();
      _controllerName.clear();
      _controllerDate.clear();
      _currentColor = const Color.fromARGB(255, 255, 255, 255);
      _dataFile = null;
    });
  }

// edit data
  void _editData() {
    final data = {
      'phoneNumber': _controllerPhoneNumber.text,
      'name': _controllerName.text,
      'date': _controllerDate.text,
      'color': _currentColor,
      'file': _dataFile,
    };
    setState(() {
      _myDataList[_editIndex!] = data;
      _controllerPhoneNumber.clear();
      _controllerName.clear();
      _controllerDate.clear();
      _currentColor = const Color.fromARGB(255, 255, 255, 255);
      _dataFile = null;
      _editIndex = null;
    });
  }

// menghapus data
  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Anda yakin ingin menghapus data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

// edit form
  void _showEditForm(int index, Map<String, dynamic> data) {
    setState(() {
      _editIndex = index;
      _controllerPhoneNumber.text = data['phoneNumber'];
      _controllerName.text = data['name'];
      _controllerDate.text = data['date'];
      _currentColor = data['color'];
      _dataFile = data['file'];
    });

    _showColorPicker(
      BlockPicker(
        pickerColor: _currentColor,
        onColorChanged: (color) {
          setState(() {
            _currentColor = color;
          });
        },
      ),
    );
  }

// color picker
  void _showColorPicker(Widget colorPicker) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick Your Color'),
          content: colorPicker,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

// open  file
  void _pickFiles() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _dataFile = pickedFile.path;
      });
    }
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    // Mendapatkan file dari object result
    final file = result.files.first;
    _openFile(file);

    setState(() {
      _dataFile = file.name;
    });
  }

  void _openFile(PlatformFile file) async {
    try {
      final filePath = file.path;
      await OpenFile.open(filePath);
    } catch (e) {
      print('Error: $e');
    }
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
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 64, 141, 177),
      ),
      body: SingleChildScrollView(
        child: Form(
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
                    fillColor: Color.fromARGB(255, 64, 141, 177),
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
                    fillColor: Color.fromARGB(255, 64, 141, 177),
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
                        decoration: InputDecoration(
                          labelText: 'Date',
                          hintText: 'Select a date',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          fillColor: const Color.fromARGB(255, 64, 141, 177),
                          filled: true,
                          suffixIcon: IconButton(
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
                                  _controllerDate.text = pickedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Color',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 100,
                      width: double.infinity,
                      color: _currentColor,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _showColorPicker(
                            ColorPicker(
                              pickerColor: _currentColor,
                              onColorChanged: (color) {
                                setState(() {
                                  _currentColor = color;
                                });
                              },
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(_currentColor),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text('Pick Color'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Pick Files',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _pickFiles,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text('Pick and Open File'),
                      ),
                    ),
                    if (_dataFile != null) Text('File Name: $_dataFile')
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_editIndex != null) {
                        _editData();
                      } else {
                        if (_formKey.currentState!.validate()) {
                          _addData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data submitted successfully!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please complete the form correctly'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _editIndex != null ? Colors.orange : Colors.blue,
                      ),
                    ),
                    child: Text(
                      _editIndex != null ? 'Update' : 'Submit',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'List Contacts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _myDataList.length,
                  itemBuilder: (context, index) {
                    final data = _myDataList[index];
                    // Mendapatkan inisial dari nama
                    final initials = _getInitials(data['name']);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          initials.substring(
                              0, 1), // Show only the first letter
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${data['name']}'),
                          Text('${data['phoneNumber']}'),
                          Text('${_formatDate(data['date'])}'),
                          // Tampilkan gambar jika ada file foto dengan format tertentu
                          if (data['file'] != null &&
                              (data['file']!.toLowerCase().endsWith('.jpg') ||
                                  data['file']!
                                      .toLowerCase()
                                      .endsWith('.jpeg') ||
                                  data['file']!.toLowerCase().endsWith('.png')))
                            Image.file(
                              File(data['file']!),
                              width: 85,
                              height: 85,
                            ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditForm(index, data);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteData(data);
                            },
                          ),
                        ],
                      ),
                      tileColor: data['color'],
                      onLongPress: () {
                        if (data['file'] != null) {
                          OpenFile.open(
                              data['file']!); // Buka file saat ditekan lama
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
