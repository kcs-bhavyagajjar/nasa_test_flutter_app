import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  // String? strFromDate;
  // String? strToDate;
  String? fromDate, toDate, fromTime, toTime;

  Future<Null> _fromDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData(
              primaryColor: Colors.blue,
              //fontFamily: FONT_NAME,
              accentColor: Colors.blue),
          child: child!,
        );
      },
    );

    if (picked == null) return;
    setState(() {
      fromDate = picked.toString();
      var _selecteDate = DateFormat('dd-MM-yyyy').format(picked);
      fromDate = _selecteDate;
    });
  }

  Future<Null> _toDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData(
              primaryColor: Colors.blue,
              //fontFamily: FONT_NAME,
              accentColor: Colors.blue),
          child: child!,
        );
      },
    );

    if (picked == null) return;
    setState(() {
      toDate = picked.toString();
      var _selectedDate = DateFormat('dd-MM-yyyy').format(picked);
      toDate = _selectedDate;
    });
  }

  Future<Null> _fromTime(
    BuildContext context,
  ) async {
    TimeOfDay? newtime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (newtime != null) {
      String formattedTimeTo =
          localizations.formatTimeOfDay(newtime, alwaysUse24HourFormat: false);
      if (formattedTimeTo != null) {
        setState(() {
          fromTime = formattedTimeTo;
        });
      }
    }
  }

  Future<Null> _toTime(
    BuildContext context,
  ) async {
    TimeOfDay? newtime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (newtime != null) {
      String formattedTimeTo =
          localizations.formatTimeOfDay(newtime, alwaysUse24HourFormat: false);
      if (formattedTimeTo != null) {
        setState(() {
          toTime = formattedTimeTo;
        });
      }
    }
  }

  static ackAlert(BuildContext context, String str) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          contentText: str,
          actions: [
            InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                Navigator.of(context).pop();
              },
              child: Container(
                width: 100,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      //fontFamily: FONT_NAME,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   var now = new DateTime.now();
  //   var currentMonthDate = new DateTime(now.year, now.month, 1);
  //
  //   var _selectedDate = DateFormat('dd MMM yyyy').format(currentMonthDate);
  //   strToDate = DateFormat('dd MM yyyy').format(now);
  //   strFromDate = DateFormat('dd MM yyyy').format(now);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$fromDate",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
              onPressed: () => _fromDate(),
              child: Text('From date'),
            ),
            // Text(
            //   style: TextStyle(
            //       color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            // ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "$toDate",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
              onPressed: () => _toDate(),
              child: Text('To date'),
            ),

            Text(
              "$fromTime",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
              onPressed: () => _fromTime(context),
              child: Text('From Time'),
            ),
            Text(
              "$toTime",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
              onPressed: () => _toTime(context),
              child: Text('To Time'),
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
                onPressed: () {
                  // var startDate =
                  //     DateFormat("dd-MM-yyyy").parse(fromdate.toString());
                  // var endDate =
                  //     DateFormat("dd-MM-yyyy").parse(todate.toString());
                  DateFormat format = DateFormat("dd-MM-yy hh:mm a");
                  DateTime d1 = format.parse(fromDate! + " " + fromTime!);
                  DateTime d2 = format.parse(toDate! + " " + toTime!);

                  if (d1.isAfter(d2)) {
                    ackAlert(
                        context, "From date cannot be greater than To Date");
                  }
                  if (d1.isBefore(d2)) {
                    ackAlert(
                        context, "to date can not be lesser than from date");
                  }
                },
                child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
