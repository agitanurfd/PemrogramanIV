import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class AdvancedForm extends StatefulWidget {
  const AdvancedForm({Key? key});

  @override
  State<AdvancedForm> createState() => _AdvancedFormState();
}

class _AdvancedFormState extends State<AdvancedForm> {
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();
  Color _currentColor = Colors.orange;
  String? _dataFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Widget'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            BuildDatePicker(),
            const SizedBox(height: 20),
            BuildColorPicker(),
            const SizedBox(height: 20),
            BuildFilePicker(),
          ],
        ),
      ),
    );
  }
}

// Date Picker
class BuildDatePicker extends StatefulWidget {
  const BuildDatePicker({Key? key});

  @override
  State<BuildDatePicker> createState() => _BuildDatePickerState();
}

class _BuildDatePickerState extends State<BuildDatePicker> {
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Date'),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectDate != null) {
                    _dueDate = selectDate;
                  }
                });
              },
            ),
          ],
        ),
        Text(DateFormat('dd-MM-yyyy').format(_dueDate)),
      ],
    );
  }
}

// Color Picker
class BuildColorPicker extends StatefulWidget {
  const BuildColorPicker({Key? key});

  @override
  State<BuildColorPicker> createState() => _BuildColorPickerState();
}

class _BuildColorPickerState extends State<BuildColorPicker> {
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();
  Color _currentColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color'),
        const SizedBox(height: 10),
        Container(
          height: 100,
          width: double.infinity,
          color: _currentColor,
        ),
        const SizedBox(height: 10),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(_currentColor),
                ),
                child: const Text('Pick Color BlockPicker'),
                onPressed: () {
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
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(_currentColor),
                ),
                child: const Text('Pick Color ColorPicker'),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Color Picker
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
}

// File Picker
class BuildFilePicker extends StatefulWidget {
  const BuildFilePicker({Key? key});

  @override
  State<BuildFilePicker> createState() => _BuildFilePickerState();
}

class _BuildFilePickerState extends State<BuildFilePicker> {
  String? _dataFile;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    // Mendapatkan file dari object result
    final file = result.files.first;
    _openFile(file);

    // Memanggil setState untuk memperbarui tampilan UI.
    setState(() {
      // Memperbarui nilai _dataFile dengan nama file yang dipilih.
      _dataFile = file.name;
    });
  }

  void _openFile(PlatformFile file) async {
    try {
      final filePath = file.path;
      await OpenFile.open(filePath);
    } catch (e) {
      // Handle any errors that occur during file opening
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick Files'),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            child: const Text('Pick and Open File'),
            onPressed: _pickFile,
          ),
        ),
        if (_dataFile != null) Text('File Name: $_dataFile'),
      ],
    );
  }
}
