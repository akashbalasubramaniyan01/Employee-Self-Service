import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;
import '../Utils/colors.dart';
import 'baseUrlPage.dart';
import 'model/loginmodel.dart';

class NewLeave extends StatefulWidget {
  const NewLeave({super.key});

  @override
  State<NewLeave> createState() => _NewLeaveState();
}

class _NewLeaveState extends State<NewLeave> {

  String dropdownValue = 'Select Leave Type';
  String SelectNoDays = '1';
  int _currentValue = 3;
  int _currentHorizontalIntValue = 1;
  TextEditingController UserName = TextEditingController();
  TextEditingController SystemDate = TextEditingController();
  TextEditingController Resaon = TextEditingController();
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  DateTime? _startDate;
  DateTime? _endDate;
  String ReasonAllert = "";

  int _currentHorizontalIntIndex = 0;
  List<String> _values = ['1', '1.5', '2', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13',
    '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25',
    '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37',
    '38', '39', '40', '41', '42', '43', '44', '45'];




  /*void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        final start = args.value.startDate;
        final end = args.value.endDate ?? args.value.startDate;
        _startDate = DateFormat('yyyy-MM-dd').format(start);
        _endDate = DateFormat('yyyy-MM-dd').format(end);
        _range = '$_startDate - $_endDate';
        print('Start Date: $_startDate');
        print('End Date: $_endDate');
      } else if (args.value is DateTime) {
        print('Selected Date: ${args.value}');
      } else if (args.value is List<DateTime>) {
        print('Date Count: ${args.value.length}');
      } else {
        print('Range Count: ${args.value.length}');
      }
    });
  }*/

 /* void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        final start = args.value.startDate;
        final end = args.value.endDate ?? args.value.startDate;
        _startDate = args.value.startDate.toString().split(' ')[0];
        _endDate = args.value.endDate?.toString().split(' ')[0] ?? _startDate;
        _startDate = DateFormat('yyyy-MM-dd').format(start);
        _endDate = DateFormat('yyyy-MM-dd').format(end);
      });
    }
  }*/
 bool checkedAfterNoon = false;
 bool checkedForeNoon = false;
  int selectedValueleave = 0; // 1 for Forenoon, 2 for Afternoon
  bool _isValid = true;

  bool showCheckboxRow = false;
  final TextEditingController _controller = TextEditingController();
  bool _isValidNumber(String value) {
    try {
      double days = double.parse(value);
      return days >= 1 && days <= 45;
    } catch (e) {
      return false; // Handle parsing errors or non-numeric input
    }
  }
  String urls="";
  Url() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      urls = prefs.getString('url') ?? "";
    });

  }
  @override
  void initState() {
    // TODO: implement initState

    Url();
  }
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    final loginModels = Get.arguments; // Retrieve the login models passed as arguments
    return Scaffold(
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {


              if(Resaon.text==""){
                setState(() {
                  ReasonAllert = "Enter the Reason";
                });
              }else{
                print("call");
                RequestLeave(
                    UserName.text, SystemDate.text, _currentHorizontalIntValue,
                    _startDate!, _endDate!, dropdownValue,Resaon.text,  selectedValueleave ,_controller.text);

              }



            },
            child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[buttonColor, buttonColor],
                  ),
                ),
                child: Center(child: Text("Submit", style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17),))),
          ),
        ],
      ),
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text(
            'Employee Self Service                           ',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),

          ),
        ),
        elevation: 1,
        leading: InkWell(onTap: () {
          Navigator.of(context).pop();
        }, child: Icon(Icons.arrow_back_ios, color: Colors.white)),


      ),

      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width/1,
          height: MediaQuery.of(context).size.height/1,

          child: Column(
            children: [
              Container(height: 15,),
              Container(
                width: 500.0,
                height: 60.0,

                decoration: new BoxDecoration(
                    color: const Color(0xFF66BB6A),
                    boxShadow: [new BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 27.0,
                    ),
                    ]
                ),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/leave-management-3.jpg', width: 49,),
                    Container(width: 13,),
                    Text("Apply Leave", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20)),


                  ],
                )),
              ),
              Container(height: 14,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(height: 2,),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFF4DA1B0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //mail icon
                                    const Icon(
                                      Icons.date_range,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),

                                    //divider svg
                                    SvgPicture.string(
                                      '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      width: 1.0,
                                      height: 15.5,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),

                                    //email address textField
                                    Expanded(
                                      child: TextField(
                                        controller: SystemDate,
                                        readOnly: true,
                                        // controller: emailController,
                                        maxLines: 1,
                                        cursorColor: Colors.white70,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,),
                                        decoration: InputDecoration(
                                            hintText: now.hour.toString() + ":" +
                                                now.minute.toString() + ":" +
                                                now.second.toString() + " - " +
                                                now.day.toString() + "/" +
                                                now.month.toString() + "/" +
                                                now.year.toString(),
                                            hintStyle: TextStyle(fontSize: 15.0,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),

                      ],
                    ),
                    Container(height: 15,),
                    Text("No of Days", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 15)),
                    Container(height: 10,),


                    Row(
                      children: [
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFF4DA1B0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //mail icon
                                    const Icon(
                                      Icons.leave_bags_at_home_sharp,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),

                                    //divider svg
                                    SvgPicture.string(
                                      '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      width: 1.0,
                                      height: 15.5,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),

                                    //email address textField
                                    Expanded(
                                      child: TextField(
                                        controller: _controller,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true), // Allow decimal input
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter days',
                                          errorText: _isValid ? null : 'Enter a number between 1 and 50',
                                          hintStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          if (value == "1.5" || value == "0.5" || value == "2.5" || value == "3.5" || value == "4.5" || value == "5.5") {
                                            setState(() {
                                              showCheckboxRow = true; // Show the checkbox row
                                              _isValid = true; // Reset validation flag as "1.5" is allowed
                                              double days = double.parse(value);
                                              _calculateEndDate(days);
                                            });
                                            return; // Exit early to prevent further processing
                                          }

                                          if (value.isNotEmpty) {
                                            double number = double.tryParse(value) ?? 0.0; // Safely parse the number
                                            if (number < 0 || number > 50) {
                                              setState(() {
                                                _isValid = false; // Set validation flag
                                                showCheckboxRow = false; // Hide the checkbox row
                                              });
                                            } else {
                                              setState(() {
                                                _isValid = true; // Reset validation flag
                                                showCheckboxRow = false; // Hide the checkbox row
                                                _calculateEndDate(number);
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              showCheckboxRow = false; // Hide the checkbox row if input is empty
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),

                      ],
                    ),
                        SizedBox(height: 8),

                    if(_controller.text=="1.5"||_controller.text=="0.5"||_controller.text=="2.5"||_controller.text=="3.5"||_controller.text=="4.5"||_controller.text=="5.5")
                      Visibility(
                        visible: showCheckboxRow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  "AM",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                value: checkedAfterNoon,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedAfterNoon = newValue!;
                                    selectedValueleave = 1;
                                    if (checkedAfterNoon && checkedForeNoon) {
                                      checkedForeNoon = false;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Only one can be selected at a time")),
                                      );
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  "PM",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                value: checkedForeNoon,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedForeNoon = newValue!;
                                    selectedValueleave = 0;
                                    if (checkedForeNoon && checkedAfterNoon) {
                                      checkedAfterNoon = false;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Only one can be selected at a time")),
                                      );
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                              ),
                            ),
                          ],
                        ),
                      ),


                    Container(height: 8,),
                    Row(
                      children: [
                      /*  GestureDetector(
                            onTap: () {
                              Get.defaultDialog(
                                  onConfirm: () {
                                    Get.back();
                                  },
                                  title: 'Leave From to Leave End Date',
                                  titleStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 15
                                  ),
                                  content: Container(
                                    width: 300,
                                    height: 300,
                                    child: Center(
                                      child: SfDateRangePicker(
                                        onSelectionChanged: _onSelectionChanged,
                                        selectionMode: DateRangePickerSelectionMode.range,
                                        initialSelectedRange: PickerDateRange(
                                            DateTime.now().subtract(const Duration(days: 4)),
                                            DateTime.now().add(const Duration(days: 3))),
                                      ),
                        
                                    ),
                                  ),
                                  radius: 10.0
                              );
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: const Color(0xFF4DA1B0),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Center(
                                    child: Text(
                                        _startDate != "" ? "$_startDate - $_endDate" : "Select Date",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                            fontSize: 15
                                        )
                                    )
                                )
                            )
                        ),*/
                        Expanded(child:    Container(
                         /* decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xFF4DA1B0),
                          ),*/
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color(0xFF4DA1B0)),
                                padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),

                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null && picked != _startDate) {
                                setState(() {
                                  _startDate = picked;
                                  _calculateEndDate(double.tryParse(_controller.text) ?? 0.0);
                                });
                              }
                            },
                            child: Text('Select Start Date',style: GoogleFonts.poppins(color: Colors.white),),
                          ),
                        ),),


                      ],
                    ),
                    Container(height: 14,),
                    if (_startDate != null|| _endDate != null)
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 12,
                      padding: EdgeInsets.only(left: 15),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFF4DA1B0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        if (_startDate != null)
                          Expanded(
                            child: Text(
                              'Start Date: ${DateFormat('dd-MM-yyyy').format(_startDate!)}',
                              style:  GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                        if (_endDate != null)
                          Expanded(
                            child: Text(
                              'End Date: ${DateFormat('dd-MM-yyyy').format(_endDate!)}',
                              style:  GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                      ],),
                    ),
                    Container(height: 15,),

                    Row(
                      children: [
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFF4DA1B0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //mail icon
                                    const Icon(
                                      Icons.edit,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),

                                    //divider svg
                                    SvgPicture.string(
                                      '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      width: 1.0,
                                      height: 15.5,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),

                                    //email address textField
                                    Expanded(
                                      child: TextField(
                                        controller: Resaon,
                                        maxLines: 1,
                                        cursorColor: Colors.white70,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,),
                                        decoration: InputDecoration(
                                            hintText: 'Reasons',
                                            hintStyle: TextStyle(fontSize: 16.0,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),


                      ],
                    ),
                    if(ReasonAllert!="")
                    Text(ReasonAllert,style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: Colors.red,
                        fontSize: 13)),
                    Container(height: 14,),
                    Container(
                      width: 500, height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFF4DA1B0),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward, color: Colors.white70),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                              'Select Leave Type',
                              'EL',
                              'CL',
                              'LOP',
                              'ML'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            dropdownColor: Color(0xFF4DA1B0),
                            hint: Text("Select the leave No of Days")
                        ),
                      ),
                    ),
                    Container(height: 14,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RequestLeave(String UserName, String SystemDate, int NoofLeave,
      DateTime Start, DateTime End, String LeaveType, String Reason, int selectedValueleave , String SelectNoDays,) async {
    String  leaveTime = "";

    print(SelectNoDays);
    if(SelectNoDays=="1.5")
    {
      if(selectedValueleave==1){
        leaveTime = "AM";
      }
      else{
        leaveTime = "PM";
      }
    }
    else{
      leaveTime = '';
    }


    try {
      String formattedDate11 = DateFormat('yyyy-MM-dd').format(Start);
      String formattedDate111 = DateFormat('yyyy-MM-dd').format(End);

      final List<Loginmodel> loginModels = Get.arguments;
      var url = "${urls}leaverequest";
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      print(formattedDate); // 2016-01-25
      print(loginModels[0].jwt); // 2016-01-25
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(
        {

        "userid" : loginModels[0].data.usrid,
        "usrname": loginModels[0].data.name,
        "requestdate": formattedDate,
          "noofdays": SelectNoDays,
        "leavefrom" : formattedDate11,
        "leaveto" : formattedDate111,
        "reasons" :Reason,
        "leavetype" : LeaveType,
        "leave_time" : leaveTime,

        }),



        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginModels[0].jwt}'
        },
      );

      print(url);
      print("SystemDate$SystemDate");
      print("SystemDate");

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());


        Get.showSnackbar(
          GetSnackBar(
            title: "Leave Request",
            message: 'Leave Request Successfully Created',
            icon: const Icon(Icons.refresh),
            duration: const Duration(seconds: 3),
          ),
        );
        Get.toNamed('/MainScreen', arguments: loginModels);
       /* Get.toNamed('/MainScreen', arguments: {
          'id': 1,
          'loginModels': loginModels,
        });*/
      } else {
        print('Failed to fetch data');
      }
    }
    catch (e) {
      print('An error occurred: $e');
    }
  }
  Future<void> _pickStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
        _endDate = null; // Reset end date when start date is picked
      });
    }
  }

  void _calculateEndDate(double days) {
    if (_startDate == null) return;

    int totalDays = days.ceil(); // Round up half-days to the next full day
    int workingDays = 1;
    DateTime currentDate = _startDate!;

    while (workingDays < totalDays) {
      currentDate = currentDate.add(Duration(days: 1));
      if (currentDate.weekday != DateTime.sunday) {
        workingDays++;
      }
    }

    setState(() {
      _endDate = currentDate;
    });
  }
}

class _RangeTextInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  _RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      final double value = double.parse(newValue.text);
      if (value >= min && value <= max) {
        return newValue; // Accept the input value within the specified range
      }
    } catch (e) {
      // Handle parsing errors or invalid input
    }
    return oldValue; // Reject the input value if it's outside the specified range
  }
}