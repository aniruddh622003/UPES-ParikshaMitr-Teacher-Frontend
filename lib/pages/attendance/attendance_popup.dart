import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';

void attendancePopup(BuildContext context) {
  final qrKey = GlobalKey(debugLabel: 'QR');
  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Scan Successful'),
            content: Text(scanData.code.toString()),
            actions: [
              TextButton(
                child: const Text('Scan Again'),
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.resumeCamera();
                },
              ),
              TextButton(
                child: const Text('Continue'),
                onPressed: () {
                  Navigator.of(context).pop();
                  int indexData = seatingPlan['data']['seating_plan']
                      .indexWhere((student) =>
                          student['sap_id'] == scanData.code.toString());
                  if (indexData == -1) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text(
                              "${scanData.code.toString()} student not found in room!"),
                          actions: [
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                controller.resumeCamera();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    int indexData = seatingPlan['data']['seating_plan']
                        .indexWhere((student) =>
                            student['sap_id'] == scanData.code.toString());
                    controller.dispose();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AttendancePage(
                              studentDetails: seatingPlan['data']
                                  ['seating_plan'][indexData])),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    });
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
                    const Text('Pending Supplies Detail',
                        style: TextStyle(
                            fontSize: fontMedium, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Align the QR code within the frame to scan'),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: onQRViewCreated,
                      ),
                    ),
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
                  child: const TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
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
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AttendancePage(studentDetails: studentDetails)));
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
