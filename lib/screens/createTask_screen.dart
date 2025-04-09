import 'package:flutter/material.dart';

class createTask_screen extends StatefulWidget {
  const createTask_screen({super.key});

  @override
  State<createTask_screen> createState() => _createTask_screenState();
}

class _createTask_screenState extends State<createTask_screen> {
  String _selectedItem = 'Option 1'; // Default value

  // List of options for the dropdown
  final List<String> _items = ['Option 1', 'Option 2', 'Option 3'];

  DateTime _selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Create Task",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                    });
                  },
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  iconEnabledColor: Colors.blue,
                  dropdownColor: Colors.green.shade100,
                  isExpanded: true,
                  itemHeight: 60,
                  items: _items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description"
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 55)
                ),
                onPressed: () => _selectDate(context),
                child: Text('Starting Date', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 55)
                ),
                onPressed: () => _selectDate(context),
                child: Text('End Date', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
