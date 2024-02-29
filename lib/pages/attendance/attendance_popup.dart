// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_room_details.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_debarred_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert';

void attendancePopup(BuildContext context) async {
  final controllerSAP = TextEditingController();
  void onBarcodeButtonPressed() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);
    controllerSAP.text = barcodeScanRes.replaceFirst("]C1", "");
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Mark Attendance',
                        style: TextStyle(
                            fontSize: fontMedium, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Align the Barcode within the frame to scan'),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GestureDetector(
                          onTap: onBarcodeButtonPressed,
                          child: Container(
                            color: gray,
                            child: Center(child: Text("Scan Barcode")),
                          ),
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                    child: Text('OR',
                        style: TextStyle(
                            fontSize: fontMedium,
                            fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                const Center(child: Text('Enter Student’s SAP ID Below')),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: blueXLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: controllerSAP,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      foregroundColor: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        const storage = FlutterSecureStorage();
                        dynamic roomData = await storage.read(key: 'room_data');

                        dynamic data = await getRoomDetails(
                            jsonDecode(roomData.toString())[0]['room_id']);
                        if (data != null) {
                          if (data.statusCode == 200) {
                            Map roomDetails = jsonDecode(data.body);
                            int indexData = roomDetails['data']['seating_plan']
                                .indexWhere((student) =>
                                    student['sap_id'] ==
                                    int.parse(controllerSAP.text));
                            if (indexData != -1) {
                              if (roomDetails['data']['seating_plan'][indexData]
                                      ['eligible'] ==
                                  'YES') {
                                Map<dynamic, dynamic> studentDetails =
                                    roomDetails['data']['seating_plan']
                                        [indexData];
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AttendancePage(
                                        studentDetails: studentDetails)));
                                
                              } else if (roomDetails['data']['seating_plan']
                                          [indexData]['eligible'] ==
                                      'F_HOLD' ||
                                  roomDetails['data']['seating_plan'][indexData]
                                          ['eligible'] ==
                                      'DEBARRED') {
                                Navigator.of(context).pop();
                                attendanceErrorDialog(context);
                              }
                            } else {
                              Navigator.pop(context);
                              errorDialog(context, 'Student not found!');
                            }
                          } else {
                            Navigator.pop(context);
                            errorDialog(context, "An error occured!");
                          }
                        } else {
                          Navigator.pop(context);
                          errorDialog(context, "An error occured!");
                        }
                      } catch (e) {
                        Navigator.pop(context);
                        errorDialog(context, "e.toString()");
                      }
                    },
                    child: const Text('Mark Attendance',
                        style: TextStyle(fontSize: fontSmall)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
