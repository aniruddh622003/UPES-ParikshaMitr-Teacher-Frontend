import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/check_room_status.dart';

import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';

import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubmissionDetails extends StatelessWidget {
  const SubmissionDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          ' Submission Details',
          style: TextStyle(
            color: white,
          ),
        ),
        backgroundColor: blue,
        elevation: 0,
      ),
      backgroundColor: blue,
      body: Center(
        child: Container(
          width: 300, // Set the width of the card
          height: 300, // Set the height of the card
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Submission Recieved",
                      style: TextStyle(
                          fontSize: fontLarge,
                          fontWeight: FontWeight.bold,
                          color: orange)),
                  const SizedBox(height: 20),
                  const Center(
                      child: Text(
                          'Your submission has been sent for authentication to the controller. Kindly wait.',
                          style: TextStyle(fontSize: fontMedium))),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        const storage = FlutterSecureStorage();
                        dynamic roomData = await storage.read(key: 'room_data');
                        dynamic response = await checkRoomStatus(
                            jsonDecode(roomData.toString())[0]['room_id']);
                        if (response.statusCode == 200) {
                          Fluttertoast.showToast(
                              msg: "Submission Approved!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          FlutterSecureStorage()
                              .delete(key: 'submission_state');
                          String? jwt =
                              await FlutterSecureStorage().read(key: 'jwt');
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(jwt: jwt),
                            ),
                          );
                        } else {
                          errorDialog(context,
                              "Submission not yet approved by the controller. Please wait.");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        foregroundColor: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Check Status'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
