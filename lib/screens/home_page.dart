import 'package:flutter/material.dart';

import 'package:gl_text/screens/pdf_service.dart';

import 'form_content_widget.dart'; // Make sure this path is correct

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Form'),
      ),
      body: const SingleChildScrollView(
        child: FormContentWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => PdfFormService.generateAndOpenFile(context),
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text("Generate PDF"),
      ),
    );
  }
}