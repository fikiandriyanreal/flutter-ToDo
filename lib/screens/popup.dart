import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Enter Text'),
              content: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter text here',
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // Close the dialog and pass the entered text back to the caller
                    Navigator.of(context).pop(_textEditingController.text);
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        ).then((enteredText) {
          // Handle the entered text from the dialog
          if (enteredText != null) {
            print('Entered text: $enteredText');
            // Perform any actions with the entered text
          }
        });
      },
      child: Text('Open Dialog'),
    );
  }
}

// Example usage:
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog with Text Field'),
      ),
      body: Center(
        child: MyDialog(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}
