// lib/pdf_service.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfFormService {
  static Future<void> generateAndOpenFile(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final pdf = pw.Document();

    final fontData = await rootBundle.load("assets/fonts/NotoSansDevanagari-Regular.ttf");
    final hindiFont = pw.Font.ttf(fontData);

    final baseStyle = pw.TextStyle(font: hindiFont, fontSize: 11);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Annexure / अनुलग्नक', style: baseStyle),
              ),
              pw.SizedBox(height: 20),

              pw.Text(
                'प्रेषक/To,\nप्रबंधक/The Manager,\nबैंक ऑफ़ इंडिया/BANK OF INDIA, __________ शाखा/Branch',
                style: baseStyle,
              ),
              pw.SizedBox(height: 20),

              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text('संपार्श्विक के रूप में स्वर्ण की स्वैच्छिक गिरवी रखने की घोषणा',
                        style: baseStyle.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Declaration for Voluntary Pledge of Gold as Collateral',
                        style: baseStyle.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),
              pw.Text(
                'मैं / श्री/सुश्री __________ आयु ____ वर्ष, पुत्र/पुत्री/पत्नी __________ निवासी __________ आधार/पहचान संख्या __________ एतद्द्वारा निम्नलिखित घोषणा करता/करती हूँ:',
                style: baseStyle,
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'I, Mr./Ms. __________ , aged ____ years, son/daughter/wife of __________ resident of __________ holding Aadhaar/ID No. __________ do hereby declare the following:',
                style: baseStyle.copyWith(fontStyle: pw.FontStyle.italic, fontSize: 10),
              ),
              pw.SizedBox(height: 15),

              ..._buildPoints(baseStyle),

              pw.Spacer(),
              pw.SizedBox(height: 40),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('उधारकर्ता के हस्ताक्षर/Signature of the Borrower:', style: baseStyle),
                    pw.SizedBox(height: 25),
                    pw.Text('नाम/Name:', style: baseStyle),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/bank_form.pdf");
    await file.writeAsBytes(await pdf.save());

    Navigator.of(context, rootNavigator: true).pop();
    await OpenFilex.open(file.path);
  }

  static List<pw.Widget> _buildPoints(pw.TextStyle baseStyle) {
    return [
      _buildPoint(
        '1.',
        'मैंने बैंक ऑफ इंडिया की __________ शाखा से कृषि/एमएसएमई श्रेणी के अंतर्गत __________ राशि के ऋण हेतु आवेदन किया है, जो आरबीआई द्वारा निर्धारित संपार्श्विक-मुक्त सीमा (दिनांक 06.12.2024 की अधिसूचना के तहत निर्धारित) के भीतर है।',
        'I have applied for a loan under the Agriculture / MSME category from __________ Branch, Bank of India, amounting to __________ which is within the RBI-prescribed collateral-free limit (as stipulated under notification dated 06.12.2024).',
        baseStyle,
      ),
      _buildPoint(
        '2.',
        'मैं अपरिवर्तनीय रूप से और स्वेच्छा से अपने व्यक्तिगत स्वर्ण के आभूषण/गहने/सिक्के जिनका वजन ______ ग्राम है और शुद्धता ______ है, को बैंक ऑफ इंडिया के पक्ष में गिरवी रखकर संपार्श्विक प्रतिभूति के रूप में प्रस्तुत करता हूँ...',
        'I irrevocably and voluntarily offer my personal gold ornaments/jewellery/Coins weighing ______ grams and of ______ purity as collateral security...',
        baseStyle,
      ),
      _buildPoint(
        '3.',
        'मैं समझता/समझती हूँ कि आरबीआई के स्पष्टीकरण (परिपत्र संख्या एफआईडीडी.सीओ.एफएसडी.बीसी. संख्या 08/05.05.010/2025-26 दिनांक 11 जुलाई, 2025) के अनुसार...',
        'I understand that, as per RBI’s clarification (Circular No. FIDD. CO. FSD. BC. No. 08/05.05.010 /2025-26 dated July 11, 2025)...',
        baseStyle,
      ),
      _buildPoint(
        '4.',
        'मैं एतद्द्वारा घोषणा और पुष्टि करता/करती हूँ कि:',
        'I hereby declare and confirm that:',
        baseStyle,
        subPoints: [
          _buildSubPoint('➢', baseStyle,
              'मैं गिरवी रखे गए स्वर्ण के आभूषणों/गहनों/सिक्कों का वैध स्वामी हूँ एवं उपर्युक्त स्वर्ण पर कोई भार नहीं लगाया गया है...',
              'I am the lawful owner of the gold ornaments/jewellery/Coins being pledged...'),
        ],
      ),
      _buildPoint(
        '5.',
        'मुझे ऋण और गिरवी की निबंधन एवं शर्तों की जानकारी है और मैं उनका पालन करने के लिए सहमत हूँ।',
        'I am aware of the terms and conditions of the loan and the pledge, and I agree to abide by them.',
        baseStyle,
      ),
      _buildPoint(
        '6.',
        'संपार्श्विक के रूप में प्रस्तुत किए गए स्वर्ण के आभूषण/गहने/सिक्कों का विवरण मेरे ऋण आवेदन दिनांक __________ में दिए गए के अनुसार है।',
        'Details of gold ornaments/jewellery/Coins offered as Collateral are as stated in my loan application dated __________.',
        baseStyle,
      ),
    ];
  }

  static pw.Widget _buildPoint(String number, String hindi, String english, pw.TextStyle baseStyle,
      {List<pw.Widget>? subPoints}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(number, style: baseStyle.copyWith(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(width: 8),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(hindi, style: baseStyle),
                pw.SizedBox(height: 2),
                pw.Text(english, style: baseStyle.copyWith(fontStyle: pw.FontStyle.italic, fontSize: 9)),
                if (subPoints != null) ...[
                  pw.SizedBox(height: 6),
                  ...subPoints,
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSubPoint(String symbol, pw.TextStyle baseStyle, String hindi, String english) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 12.0, bottom: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(symbol, style: baseStyle),
          pw.SizedBox(width: 6),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(hindi, style: baseStyle),
                pw.SizedBox(height: 2),
                pw.Text(english, style: baseStyle.copyWith(fontStyle: pw.FontStyle.italic, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
