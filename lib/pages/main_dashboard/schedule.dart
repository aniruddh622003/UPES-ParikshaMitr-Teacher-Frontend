// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});
  @override
  _Schedule createState() => _Schedule();
}

class _Schedule extends State<Schedule> {
  List<Map> data = [
    {
      'timeSlot': '9 AM - 12 PM',
      'task': 'Invigilation Duty',
      'room': 'Controller Room',
      'message':
          'Go to the controller room, press start invigilation and scan the QR for further  instructions'
    },
    {
      'timeSlot': '12 PM - 1 PM',
      'task': 'Lunch Break',
      'room': 'Cafeteria',
      'message':
          'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
    },
  ];

  Map dateData = {
    '2024-01-09': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
    '2024-01-10': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      }
    ],
    '2024-01-11': [
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
    '2024-01-12': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
    '2024-01-16': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
    '2024-01-17': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
  };

  int selectedContainerIndex = 0;
  String selectedDate = '';
  List<Widget> makeDateWidgets(List<dynamic> dates) {
    List<Widget> dateWidgets = [];
    for (var x in dates) {
      String date = x as String;
      Color backgroundColor;
      Color textColor;
      DateTime now = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      DateTime dateD = DateTime.parse(date);
      String monthName = DateFormat('MMM').format(DateTime(
          int.parse(date.split('-')[0]), int.parse(date.split('-')[1])));
      if (dateD.isBefore(now)) {
        backgroundColor = greenXLight;
        textColor = orange;
      } else if (dateD.isAfter(now)) {
        backgroundColor = blueXLight;
        textColor = orange;
      } else {
        backgroundColor = orange;
        textColor = white;
      }
      dateWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
              selectedContainerIndex = 0;
              data = dateData[date];
            });
          },
          child: Container(
            width: 65,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selectedDate == date ? blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.split('-')[2],
                  textScaler: const TextScaler.linear(1),
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontLarge,
                  ),
                ),
                Text(
                  monthName,
                  textScaler: const TextScaler.linear(1),
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      dateWidgets.add(const SizedBox(width: 10));
    }
    return dateWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   "View Invigilation Schedule",
        //textScaler: const TextScaler.linear(1),
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // ),

        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: blue,
          ),
          child: const Column(
            children: [
              Text(
                "Welcome to UPES ParikshaMitr Teacher",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 30, color: white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please Scan the QR by pressing the button on the top-right corner to start invigilation.",
                textScaler: TextScaler.linear(1),
                style: TextStyle(fontSize: 20, color: white),
              ),
            ],
          ),
        ),
        const Text(
          "Instructions",
          textScaler: TextScaler.linear(1),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(
                      double.infinity, 60), // Set a minimum height here
                ),
                onPressed: () async {
                  try {
                    // Load the PDF file from the assets
                    ByteData data = await rootBundle.load(
                        'assets/Examination Guidelines for Control Room Supervisors (CRS).pdf');

                    // Get the application documents directory
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    String appDocPath = appDocDir.path;

                    // Write the file
                    File file = File(
                        '$appDocPath/Examination Guidelines for Control Room Supervisors (CRS).pdf');
                    await file.writeAsBytes(data.buffer
                        .asUint8List(data.offsetInBytes, data.lengthInBytes));

                    // Open the file
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                              title: const Text("Control Room Guidlines",
                                  textScaler: TextScaler.linear(1))),
                          body: PDFView(
                            filePath: file.path,
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    errorDialog(context, e.toString());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: white,
                    ), // Add your icon here
                    const SizedBox(width: 10),
                    // Add some spacing between the icon and text
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10), // Add left margin here
                        child: const Text('Control room instructions',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 20,
                              color: white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(
                      double.infinity, 60), // Set a minimum height here
                ),
                onPressed: () async {
                  try {
                    // Load the PDF file from the assets
                    ByteData data = await rootBundle.load(
                        'assets/Examination Guidelines for Flying Squad.pdf');

                    // Get the application documents directory
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    String appDocPath = appDocDir.path;

                    // Write the file
                    File file = File(
                        '$appDocPath/Examination Guidelines for Flying Squad.pdf');
                    await file.writeAsBytes(data.buffer
                        .asUint8List(data.offsetInBytes, data.lengthInBytes));

                    // Open the file
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                              title: const Text(
                            "Flying Squad Guidlines",
                            textScaler: TextScaler.linear(1),
                          )),
                          body: PDFView(
                            filePath: file.path,
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    errorDialog(context, e.toString());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: white,
                    ), // Add your icon here
                    const SizedBox(width: 10),
                    // Add some spacing between the icon and text
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10), // Add left margin here
                        child: const Text('Flying Squad instructions',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 20,
                              color: white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(
                      double.infinity, 60), // Set a minimum height here
                ),
                onPressed: () async {
                  try {
                    // Load the PDF file from the assets
                    ByteData data = await rootBundle.load(
                        'assets/Examination Guidelines for Invigilators.pdf');

                    // Get the application documents directory
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    String appDocPath = appDocDir.path;

                    // Write the file
                    File file = File(
                        '$appDocPath/Examination Guidelines for Invigilators.pdf');
                    await file.writeAsBytes(data.buffer
                        .asUint8List(data.offsetInBytes, data.lengthInBytes));

                    // Open the file
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                              title: const Text(
                            "Invigilator Guidlines",
                            textScaler: TextScaler.linear(1),
                          )),
                          body: PDFView(
                            filePath: file.path,
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    errorDialog(context, e.toString());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: white,
                    ), // Add your icon here
                    const SizedBox(width: 10),
                    // Add some spacing between the icon and text
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10), // Add left margin here
                        child: const Text('Invigilator instructions',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 20,
                              color: white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 100,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: makeDateWidgets(dateData.keys.toList()),
        //   ),
        // ),
        // Column(
        //   children: List<Widget>.generate(
        //     data.length, // Replace with your number of containers
        //     (index) {
        //       Color selectedColorBG = purple;
        //       Color baseColorBG = purpleLight;
        //       Color selectedColorText = white;
        //       Color baseColorText = black;
        //       Color bgColor = (selectedContainerIndex == index)
        //           ? selectedColorBG
        //           : baseColorBG;
        //       Color textColor = (selectedContainerIndex == index)
        //           ? selectedColorText
        //           : baseColorText;
        //       Widget contents = (selectedContainerIndex == index)
        //           ? Container(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 15, vertical: 10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(
        //                         data[index]['timeSlot'],
        //textScaler: const TextScaler.linear(1),
        //                         style: TextStyle(
        //                           color: textColor,
        //                           fontSize: fontSmall,
        //                         ),
        //                       ),
        //                       Text(
        //                         data[index]['room'],
        //textScaler: const TextScaler.linear(1),
        //                         style: TextStyle(
        //                           color: textColor,
        //                           fontSize: fontSmall,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   Text(
        //                     data[index]['task'],
        //textScaler: const TextScaler.linear(1),
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontMedium,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                   Text(
        //                     '${data[index]['message']}',
        //textScaler: const TextScaler.linear(1),
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontSmall,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )
        //           : Container(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 15, vertical: 10),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     data[index]['timeSlot'],
        //textScaler: const TextScaler.linear(1),
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontMedium,
        //                     ),
        //                   ),
        //                   Text(
        //                     data[index]['task'],
        //textScaler: const TextScaler.linear(1),
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontMedium,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             );
        //       return GestureDetector(
        //         onTap: () {
        //           setState(() {
        //             selectedContainerIndex = index;
        //           });
        //         },
        //         child: Container(
        //             margin: const EdgeInsets.only(top: 5),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: bgColor,
        //             ),
        //             child: contents),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
