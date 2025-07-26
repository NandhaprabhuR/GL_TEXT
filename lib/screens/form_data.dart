// lib/form_data.dart
class FormData {
  final String branch;
  final String name;
  final String age;
  final String relation;
  final String resident;
  final String aadhaar;
  // Note: I'm keeping it simple. You can add controllers for every blank.

  FormData({
    this.branch = '',
    this.name = '',
    this.age = '',
    this.relation = '',
    this.resident = '',
    this.aadhaar = '',
  });
}




// // lib/form_data.dart
//
// // A simple class to hold the data from the form fields.
// class FormData {
//   final String branch;
//   final String name;
//   final String age;
//   final String relation;
//   final String resident;
//   final String aadhaar;
//   // Add more fields here as needed for all blanks
//
//   FormData({
//     this.branch = '',
//     this.name = '',
//     this.age = '',
//     this.relation = '',
//     this.resident = '',
//     this.aadhaar = '',
//   });
// }