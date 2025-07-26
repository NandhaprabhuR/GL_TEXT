import 'package:flutter/material.dart';
import 'form_content_widget.dart'; // Imports the on-screen form widget
import 'pdf_service.dart'; // Imports the PDF generation service

class PdfDesign extends StatelessWidget {
  const PdfDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Generator'),
        backgroundColor: Colors.black,
      ),
      // The body now displays your form from the separate file
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: FormContentWidget(),
      ),
      // The button now calls your PDF service to generate and open the file
      floatingActionButton: FloatingActionButton(
        onPressed: () => PdfFormService.generateAndOpenFile(context),
        child: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
