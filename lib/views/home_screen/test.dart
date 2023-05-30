import 'package:flutter/material.dart';

class DropdownScreen extends StatefulWidget {
  @override
  _DropdownScreenState createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {
  String? _firstDropdownValue;
  String? _secondDropdownValue;

  final Map<String, List<String>> _secondDropdownItems = {
    "Item 1": ["Red", "Green", "Blue"],
    "Item 2": ["Black", "White"],
    "Item 3": ["Pink", "Teal", "Yellow", "Purple"],
    "Item 4": ["Orange", "Gray"],
    "Item 5": ["Brown", "Turquoise", "Lavender", "Magenta", "Cyan"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select an item from the first dropdown:"),
            DropdownButton(
              hint: Text("Select Item"),
              value: _firstDropdownValue,
              items: [
                DropdownMenuItem<String>(
                  value: "Item 1",
                  child: Text("Item 1"),
                ),
                DropdownMenuItem<String>(
                  value: "Item 2",
                  child: Text("Item 2"),
                ),
                DropdownMenuItem<String>(
                  value: "Item 3",
                  child: Text("Item 3"),
                ),
                DropdownMenuItem<String>(
                  value: "Item 4",
                  child: Text("Item 4"),
                ),
                DropdownMenuItem<String>(
                  value: "Item 5",
                  child: Text("Item 5"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _firstDropdownValue = value;
                  _secondDropdownValue = null;
                });
              },
            ),
            SizedBox(height: 20),
            if (_firstDropdownValue != null)
              Text("Select an Color from the second dropdown:"),
            if (_firstDropdownValue != null)
              DropdownButton(
                value: _secondDropdownValue,
                items: _secondDropdownItems[_firstDropdownValue]!
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _secondDropdownValue = value;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
