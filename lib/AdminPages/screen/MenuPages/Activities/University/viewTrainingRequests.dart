// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// import 'package:flutter/material.dart';

// class ViewTrainingRequestsPage extends StatefulWidget {
//   @override
//   _ViewTrainingRequestsPageState createState() => _ViewTrainingRequestsPageState();
// }

// class _ViewTrainingRequestsPageState extends State<ViewTrainingRequestsPage> {
//   List<TrainingRequest> trainingRequests = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchTrainingRequests();
//   }

//   Future<void> fetchTrainingRequests() async {
//     // Fetch data from the backend
//     // This is just a placeholder. Replace it with your actual backend call.
//     List<TrainingRequest> fetchedRequests = [
//       TrainingRequest(
//         name: 'محمد أحمد',
//         email: 'mohamed@example.com',
//         university: 'جامعة النجاح',
//         major: 'هندسة برمجيات',
//         trainingHours: '120',
//         cv: 'resume.pdf',
//       ),
//       TrainingRequest(
//         name: 'علي سعيد',
//         email: 'ali@example.com',
//         university: 'جامعة بيرزيت',
//         major: 'علوم الحاسوب',
//         trainingHours: '100',
//         cv: 'resume2.pdf',
//       ),
//       // Add more training requests as needed
//     ];

//     setState(() {
//       trainingRequests = fetchedRequests;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Color(0xFF071533),
//         fontFamily: 'Amiri',
//         textTheme: TextTheme(
//           bodyText2: TextStyle(color: Color(0xFF071533)),
//         ),
//       ),
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'طلبات التدريب',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontFamily: 'Amiri',
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF071533),
//                             fontSize: 18,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Color(0xFF071533)),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Table(
//                             columnWidths: {
//                               0: FlexColumnWidth(1),
//                               1: FlexColumnWidth(1),
//                               2: FlexColumnWidth(1),
//                               3: FlexColumnWidth(1),
//                               4: FlexColumnWidth(1),
//                               5: FlexColumnWidth(1),
//                             },
//                             children: [
//                               TableRow(
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFe0e0e0),
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     topRight: Radius.circular(20),
//                                   ),
//                                 ),
//                                 children: [
//                                   _buildHeaderCell('السيرة الذاتية'),
//                                   _buildHeaderCell('عدد ساعات التدريب'),
//                                   _buildHeaderCell('التخصص'),
//                                   _buildHeaderCell('اسم الجامعة'),
//                                   _buildHeaderCell('البريد الإلكتروني'),
//                                   _buildHeaderCell('الاسم الثلاثي'),
//                                 ],
//                               ),
//                               ...trainingRequests.map((request) {
//                                 return TableRow(
//                                   children: [
//                                     _buildTableCell(request.cv),
//                                     _buildTableCell(request.trainingHours),
//                                     _buildTableCell(request.major),
//                                     _buildTableCell(request.university),
//                                     _buildTableCell(request.email),
//                                     _buildTableCell(request.name),
//                                   ],
//                                 );
//                               }).toList(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   TableCell _buildHeaderCell(String text) {
//     return TableCell(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           text,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontFamily: 'Amiri',
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF071533),
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }

//   TableCell _buildTableCell(String text) {
//     return TableCell(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           text,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontFamily: 'Amiri',
//             color: Color(0xFF071533),
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TrainingRequest {
//   final String name;
//   final String email;
//   final String university;
//   final String major;
//   final String trainingHours;
//   final String cv;

//   TrainingRequest({
//     required this.name,
//     required this.email,
//     required this.university,
//     required this.major,
//     required this.trainingHours,
//     required this.cv,
//   });
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ViewTrainingRequestsPage extends StatefulWidget {
  @override
  _ViewTrainingRequestsPageState createState() =>
      _ViewTrainingRequestsPageState();
}

class _ViewTrainingRequestsPageState extends State<ViewTrainingRequestsPage> {
  List<TrainingRequest> trainingRequests = [];

  @override
  void initState() {
    super.initState();
    fetchTrainingRequests();
  }

  Future<void> fetchTrainingRequests() async {
    final String apiUrl = "http://localhost:9999/university-training/all";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('Response body:');
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = json.decode(response.body);
        List<TrainingRequest> fetchedRequests =
            data.map((item) => TrainingRequest.fromJson(item)).toList();

        setState(() {
          trainingRequests = fetchedRequests;
        });
      } else {
        // Handle the error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch training requests')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch training requests')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF071533),
        fontFamily: 'Amiri',
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Color(0xFF071533)),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'طلبات التدريب',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF071533),
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF071533)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Table(
                            columnWidths: {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                              4: FlexColumnWidth(1),
                              5: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Color(0xFFe0e0e0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                children: [
                                  _buildHeaderCell('السيرة الذاتية'),
                                  _buildHeaderCell('عدد ساعات التدريب'),
                                  _buildHeaderCell('التخصص'),
                                  _buildHeaderCell('اسم الجامعة'),
                                  _buildHeaderCell('البريد الإلكتروني'),
                                  _buildHeaderCell('الاسم الثلاثي'),
                                ],
                              ),
                              ...trainingRequests.map((request) {
                                return TableRow(
                                  children: [
                                    _buildCvCell(request.cv ?? 'No CV available'),
                                    _buildTableCell(
                                        request.trainingHours?.toString() ?? 'N/A'),
                                    _buildTableCell(request.major ?? 'N/A'),
                                    _buildTableCell(request.university ?? 'N/A'),
                                    _buildTableCell(request.email ?? 'N/A'),
                                    _buildTableCell(request.name ?? 'N/A'),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableCell _buildHeaderCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Amiri',
            fontWeight: FontWeight.bold,
            color: Color(0xFF071533),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  TableCell _buildTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Amiri',
            color: Color(0xFF071533),
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  TableCell _buildCvCell(String? url) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: url != null ? () => _launchURL(url) : null,
          child: Text(
            url != null ? 'عرض السيرة الذاتية' : 'لا يوجد سيرة ذاتية',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Amiri',
              color: url != null ? Colors.blue : Colors.red,
              decoration: url != null ? TextDecoration.underline : null,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class TrainingRequest {
  final String? name;
  final String? email;
  final String? university;
  final String? major;
  final int? trainingHours;
  final String? cv;

  TrainingRequest({
    this.name,
    this.email,
    this.university,
    this.major,
    this.trainingHours,
    this.cv,
  });

  factory TrainingRequest.fromJson(Map<String, dynamic> json) {
    return TrainingRequest(
      name: json['fullName'] as String?,
      email: json['email'] as String?,
      university: json['universityName'] as String?,
      major: json['field'] as String?,
      trainingHours: json['trainingHours'] as int?,
      cv: json['cv'] as String?,
    );
  }
}