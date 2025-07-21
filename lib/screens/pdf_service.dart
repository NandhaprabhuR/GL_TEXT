import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfFormService {
  static get alphabetic => null;

  static Future<void> generateAndOpenFile(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final pdf = pw.Document();
    final fontData = await rootBundle.load("assets/fonts/NotoSansDevanagari-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);
    final hindiTheme = pw.ThemeData.withFont(base: ttf, bold: ttf);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(ttf),
              _buildTitle(ttf),
              _buildPersonalInfo(hindiTheme),
              _buildPoint('1.', hindiTheme,
                  ['मैंने बैंक ऑफ इंडिया की ',_buildTextField('branch_name_1', width: 80),' शाखा से कृषि/एमएसएमई श्रेणी के अंतर्गत ',_buildTextField('loan_amount_1', width: 80),' राशि के ऋण हेतु आवेदन किया है, जो आरबीआई द्वारा निर्धारित संपार्श्विक-मुक्त सीमा (दिनांक 06.12.2024 की अधिसूचना के तहत निर्धारित) के भीतर है।'],
                  ['I have applied for a loan under the Agriculture / MSME category from Branch, Bank of India, amounting to ',_buildTextField('loan_amount_eng_1', width: 80),' which is within the RBI-prescribed collateral-free limit (as stipulated under notification dated 06.12.2024).']
              ),
              _buildPoint('2.', hindiTheme,
                  ['मैं अपरिवर्तनीय रूप से और स्वेच्छा से अपने व्यक्तिगत स्वर्ण के आभूषण/गहने/सिक्के जिनका वजन ',_buildTextField('grams', width: 40),' ग्राम है और शुद्धता ',_buildTextField('purity', width: 40),' है...'],
                  ['I irrevocably and voluntarily offer my personal gold ornaments/jewellery/Coins weighing ',_buildTextField('grams_eng', width: 40),' grams and of ',_buildTextField('purity_eng', width: 40),' purity...']
              ),
              _buildPoint('3.', hindiTheme,
                  ['मैं समझता/समझती हूँ कि आरबीआई के स्पष्टीकरण (परिपत्र संख्या एफआईडीडी.सीओ.एफएसडी.बीसी. संख्या 08/05.05.010/2025-26 दिनांक 11 जुलाई, 2025) के अनुसार...'],
                  ['I understand that, as per RBIs clarification (Circular No. FIDD. CO. FSD. BC. No. 08/05.05.010 /2025-26 dated July 11, 2025), such voluntary pledge...']
              ),
              _buildPoint('4.', hindiTheme,
                  ['मैं एतद्द्वारा घोषणा, और पुष्टि करता/करती हूँ कि:'],
                  ['I hereby declare and confirm that:'],
                  subPoints: [_buildSubPoint('➢', hindiTheme, 'मैं गिरवी रखे गए स्वर्ण के आभूषणों/गहनों/सिक्कों का वैध स्वामी हूँ एवं उपर्युक्त स्वर्ण पर कोई भार नहीं लगाया गया है...', 'I am the lawful owner of the gold ornaments/jewellery/Coins being pledged...')]
              ),
              _buildPoint('5.', hindiTheme,
                  ['मुझे ऋण और गिरवी की निबंधन एवं शर्तों की जानकारी है और मैं उनका पालन करने के लिए सहमत हूँ।'],
                  ['I am aware of the terms and conditions of the loan and the pledge, and I agree to abide by them.']
              ),
              _buildPoint('6.', hindiTheme,
                  ['संपार्श्विक के रूप में प्रस्तुत किए गए स्वर्ण के आभूषण/गहने/सिक्कों का विवरण मेरे ऋण आवेदन दिनांक ',_buildTextField('application_date', width: 70),' में दिए गए के अनुसार है।'],
                  ['Details of gold ornaments/jewellery/Coins offered as Collateral are as stated in my loan application dated ',_buildTextField('application_date_eng', width: 70),'.']
              ),
              pw.Spacer(),
              _buildSignature(ttf),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/bank_form_complete.pdf");
    await file.writeAsBytes(await pdf.save());

    Navigator.of(context, rootNavigator: true).pop();
    await OpenFilex.open(file.path);
  }

  // PDF Helper Widgets (abbreviated for clarity, use full code from previous response)
  static pw.Widget _buildHeader(pw.Font ttf) => pw.Container(/* ... */);
  static pw.Widget _buildTitle(pw.Font ttf) => pw.Container(/* ... */);
  static pw.Widget _buildPersonalInfo(pw.ThemeData hindiTheme) => pw.Container(/* ... */);
  static pw.Widget _buildSignature(pw.Font ttf) => pw.Container(/* ... */);
  static pw.Widget _buildTextField(String name, {double width = double.infinity}) => pw.SizedBox(width: width, height: 12, child: pw.TextField(name: name, textStyle: const pw.TextStyle(fontSize: 9)));
  static pw.RichText _buildRichText(List<dynamic> content, pw.TextStyle style) => pw.RichText(text: pw.TextSpan(style: style, children: content.map((item) { if (item is String) return pw.TextSpan(text: item); if (item is pw.Widget) return pw.WidgetSpan(child: item, baseline: alphabetic); return const pw.TextSpan(); }).toList()));
  static pw.Widget _buildCombinedLine({required pw.ThemeData hindiTheme, required List<dynamic> hindi, required List<dynamic> english}) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [ if (hindi.isNotEmpty) _buildRichText(hindi, pw.TextStyle.defaultStyle().copyWith(font: hindiTheme.font, fontSize: 9)), if (english.isNotEmpty) _buildRichText(english,  pw.TextStyle(fontStyle: pw.FontStyle.italic, fontSize: 8)), pw.SizedBox(height: 1), ]);
  static pw.Widget _buildPoint(String number, pw.ThemeData hindiTheme, List<dynamic> hindiContent, List<dynamic> englishContent, {List<pw.Widget>? subPoints}) => pw.Padding(padding: const pw.EdgeInsets.only(bottom: 6.0), child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [ pw.Text(number, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), pw.SizedBox(width: 5), pw.Expanded(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [ _buildRichText(hindiContent, pw.TextStyle.defaultStyle().copyWith(font: hindiTheme.font, fontSize: 9)), pw.SizedBox(height: 2), _buildRichText(englishContent,  pw.TextStyle(fontStyle: pw.FontStyle.italic, fontSize: 8)), if (subPoints != null) pw.Padding(padding: const pw.EdgeInsets.only(top: 4, left: 10), child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: subPoints)), ])), ]));
  static pw.Widget _buildSubPoint(String symbol, pw.ThemeData hindiTheme, String hindi, String english) => pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [ pw.Text(symbol), pw.SizedBox(width: 5), pw.Expanded(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [ pw.Text(hindi, style: pw.TextStyle.defaultStyle().copyWith(font: hindiTheme.font, fontSize: 9)), pw.SizedBox(height: 2), pw.Text(english, style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontSize: 8)), ])), ]);
}

extension on pw.ThemeData {
  get font => null;
}