// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class DateConverterScreen extends StatefulWidget {
  const DateConverterScreen({Key? key}) : super(key: key);

  @override
  DateConverterScreenState createState() => DateConverterScreenState();
}

class DateConverterScreenState extends State<DateConverterScreen> {
  DateTime _selectedDate = DateTime.now();
  String _convertedDate = "";
  bool _isNepaliToEnglish = true;

  final List<int> _years = List.generate(51, (index) => 1980 + index);
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<int> _days = List.generate(31, (index) => index + 1);

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;

  Future<void> changeDate(BuildContext context) async {
    if (_isNepaliToEnglish) {
      final NepaliDateTime? picked = await showMaterialDatePicker(
        context: context,
        initialDate: _selectedDate.toNepaliDateTime(),
        firstDate: NepaliDateTime(1980, 1, 1),
        lastDate: NepaliDateTime(2030, 12, 31),
      );

      if (picked != null) {
        setState(() {
          _selectedDate = picked.toDateTime();
          _selectedYear = picked.year;
          _selectedMonth = picked.month;
          _selectedDay = picked.day;
          _convertDate();
        });
      }
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2030),
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
          _selectedYear = picked.year;
          _selectedMonth = picked.month;
          _selectedDay = picked.day;
          _convertDate();
        });
      }
    }
  }

  void _convertDate() {
    if (_isNepaliToEnglish) {
      NepaliDateTime nt =
          NepaliDateTime(_selectedYear, _selectedMonth, _selectedDay);
      _convertedDate = nt.format("yyyy-MM-dd");
    } else {
      NepaliDateTime nt = NepaliDateTime.fromDateTime(_selectedDate);

      _convertedDate = nt.format("yyyy-MM-dd");
    }
  }

  @override
  void initState() {
    super.initState();
    _convertDate();
  }

  final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: const Color.fromARGB(255, 80, 137, 183),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.all(16.0),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 242, 242),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isNepaliToEnglish = true;
                          _convertDate();
                        });
                      },
                      style: customButtonStyle,
                      child: const Text(
                        "Nepali to English",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isNepaliToEnglish = false;
                          _convertDate();
                        });
                      },
                      style: customButtonStyle,
                      child: const Text(
                        "English to Nepali",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: _selectedYear,
                      items: _years.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedYear = value ?? DateTime.now().year;
                          _convertDate();
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _months[_selectedMonth - 1],
                      items: _months.map((String month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(month),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedMonth = _months.indexOf(value ?? "");
                          _convertDate();
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<int>(
                      value: _selectedDay,
                      items: _days.map((int day) {
                        return DropdownMenuItem<int>(
                          value: day,
                          child: Text(day.toString()),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedDay = value ?? DateTime.now().day;
                          _convertDate();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(height: 20.0),
                const SizedBox(height: 30.0),
                Text(
                  _isNepaliToEnglish ? "English Date" : "Nepali Date",
                  style: GoogleFonts.getFont(
                    'Anton',
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                ),
                Text(
                  _convertedDate,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
