import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class HorizontalDatePicker extends StatefulWidget {
  @override
  _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {

  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  @override void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.white12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: DatePicker(
                  DateTime.now().add(Duration(days: 0)),
                  daysCount: 56,
                  width: 45,
                  height: 80,
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.orange,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ),
            ],
          ),
        );
  }
}