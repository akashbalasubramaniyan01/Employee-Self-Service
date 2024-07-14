import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Utils/colors.dart';
import 'insertLeaveController.dart';

class FormPopup extends StatelessWidget {
  final FormController formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(height: 12,),
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
                    Text("Apply Permission", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20)),


                  ],
                )),
              ),
              Container(height: 30,),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() => TextField(
                        decoration: InputDecoration(
                          labelText: 'Request Date',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: formController.requestDate.value),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            formController.updateRequestDate(pickedDate);
                          }
                        },
                      )),
                    ),
                  ),

                ],
              ),
              Container(height: 12,),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() => TextField(
                        decoration: InputDecoration(
                          labelText: 'Time From',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: formController.timeFrom.value),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final now = DateTime.now();
                            final time = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
                            formController.timeFrom.value = DateFormat('HH:mm:ss').format(time);
                            formController.calculateHours(); // Calculate hours after picking time
                          }
                        },
                      )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() => TextField(
                        decoration: InputDecoration(
                          labelText: 'Time To',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: formController.timeTo.value),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final now = DateTime.now();
                            final time = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
                            formController.timeTo.value = DateFormat('HH:mm:ss').format(time);
                            formController.calculateHours(); // Calculate hours after picking time
                          }
                        },
                      )),
                    ),
                  ),
                ],
              ),

            /*  Container(height: 12,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Purpose',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        formController.purpose.value = value;
                      },
                    ),
                  ),
                  Container(height: 12,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Remarks',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        formController.remarks.value = value;
                      },
                    ),
                  ),
                ],
              ),*/

              Row(
                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'No of Hours',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),

                      controller: formController.TotalHours,
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 150,),
            ],
          ),
        ),
      ),

      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {


              formController.CreatePermision();

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
    );
  }}