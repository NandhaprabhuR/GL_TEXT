// lib/form_content_widget.dart
import 'package:flutter/material.dart';

class FormContentWidget extends StatelessWidget {
  const FormContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double p = 12;
    const double indent = 16;

    // Helper for underlined blank spaces
    Widget blankSpace(double width) {
      return Container(
        width: width,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text('Annexure / अनुलग्नक'),
          ),
          const SizedBox(height: 15),
          const Text('प्रेषक/To,\nप्रबंधक/The Manager,\nबैंक ऑफ़ इंडिया/BANK OF INDIA, __________ शाखा/Branch'),
          const SizedBox(height: 20),
          const Center(
            child: Column(
              children: [
                Text('संपार्श्विक के रूप में स्वर्ण की स्वैच्छिक गिरवी रखने की घोषणा', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                Text('Declaration for Voluntary Pledge of Gold as Collateral', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // --- Full Personal Details Section ---
          const Text('मैं / श्री/सुश्री __________ आयु ____ वर्ष, पुत्र/पुत्री/पत्नी __________ निवासी __________ आधार/पहचान संख्या __________ एतद्द्वारा निम्नलिखित घोषणा करता/करती हूँ:'),
          const SizedBox(height: 4),
          const Text('I, Mr./Ms. __________ , aged ____ years, son/daughter/wife of __________ resident of __________ holding Aadhaar/ID No. __________ do hereby declare the following:', style: TextStyle(fontSize: p)),
          const SizedBox(height: 15),

          // --- All points with full, unabbreviated text ---
          _buildPoint('1.',
              'मैंने बैंक ऑफ इंडिया की __________ शाखा से कृषि/एमएसएमई श्रेणी के अंतर्गत __________ राशि के ऋण हेतु आवेदन किया है, जो आरबीआई द्वारा निर्धारित संपार्श्विक-मुक्त सीमा (दिनांक 06.12.2024 की अधिसूचना के तहत निर्धारित) के भीतर है।',
              'I have applied for a loan under the Agriculture / MSME category from __________ Branch, Bank of India, amounting to __________ which is within the RBI-prescribed collateral-free limit (as stipulated under notification dated 06.12.2024).'),
          _buildPoint('2.',
              'मैं अपरिवर्तनीय रूप से और स्वेच्छा से अपने व्यक्तिगत स्वर्ण के आभूषण/गहने/सिक्के जिनका वजन ______ ग्राम है और शुद्धता ______ है, को बैंक ऑफ इंडिया के पक्ष में गिरवी रखकर संपार्श्विक प्रतिभूति के रूप में प्रस्तुत करता हूँ, ताकि उक्त ऋण रुपये __________ और उस पर देय सभी ब्याज और अन्य धनराशियों (इसके अंतर्गत देय अतिरिक्त और/या दंडात्मक शुल्क सहित) और सभी लागत, प्रभार और व्यय (कानूनी लागत सहित) का भुगतान किया जा सके।',
              'I irrevocably and voluntarily offer my personal gold ornaments/jewellery/Coins weighing ______ grams and of ______purity as collateral security by pledging the same in favour of Bank of India for the due repayment of the said loan of Rs. __________ and all interest and other monies due and payable thereon (including additional and/or penal charges payable thereunder) and also all costs, charges and expenses (including legal costs).'),
          _buildPoint('3.',
              'मैं समझता/समझती हूँ कि आरबीआई के स्पष्टीकरण (परिपत्र संख्या एफआईडीडी.सीओ.एफएसडी.बीसी. संख्या 08/05.05.010/2025-26 दिनांक 11 जुलाई, 2025) के अनुसार, स्वर्ण के आभूषण/गहने/सिक्के की ऐसी स्वैच्छिक गिरवी रखने को दिनांक 06.12.2024 की अधिसूचना के तहत जारी आरबीआई दिशानिर्देशों का उल्लंघन नहीं माना जाएगा।',
              'I understand that, as per RBIs clarification (Circular No. FIDD. CO. FSD. BC. No. 08/05.05.010 /2025-26 dated July 11, 2025), such voluntary pledge of gold ornaments / jewellery/coins will not be construed as violation of the RBI guidelines issued under notification dated 06.12.2024.'),
          _buildPoint('4.',
              'मैं एतद्द्वारा घोषणा और पुष्टि करता/करती हूँ कि:',
              'I hereby declare and confirm that:'),
          // Sub-points for question 4
          _buildSubPoint('➢', 'मैं गिरवी रखे गए स्वर्ण के आभूषणों/गहनों/सिक्कों का वैध स्वामी हूँ एवं उपर्युक्त स्वर्ण पर कोई भार नहीं लगाया गया है एवं कि यह गिरवी मेरे द्वारा स्वेच्छा से, बैंक से किसी भी प्रकार के दबाव, जबरदस्ती या बाध्यता के बिना अपने ऋण को सुरक्षित करने हेतु की गई है...'),
          _buildSubPoint('➢', 'I am the lawful owner of the gold ornaments/jewellery/Coins being pledged and no charge has been created against the aforesaid gold ornaments/jewellery /coins elsewhere and that the pledge is made by me voluntarily, without any pressure, coercion or compulsion from the bank for securing the due repayment of the aforesaid loan of Rs. __________ ...'),

          _buildPoint('5.',
              'मुझे ऋण और गिरवी की निबंधन एवं शर्तों की जानकारी है और मैं उनका पालन करने के लिए सहमत हूँ।',
              'I am aware of the terms and conditions of the loan and the pledge, and I agree to abide by them.'),
          _buildPoint('6.',
              'संपार्श्विक के रूप में प्रस्तुत किए गए स्वर्ण के आभूषण/गहने/सिक्कों का विवरण मेरे ऋण आवेदन दिनांक __________ में दिए गए के अनुसार है।',
              'Details of gold ornaments/jewellery/Coins offered as Collateral are as stated in my loan application dated __________.'),
          const SizedBox(height: 40),
          const Align(
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('उधारकर्ता के हस्ताक्षर/Signature of the Borrower:'),
                SizedBox(height: 25),
                Text('नाम/Name:'),
              ],
            ),
          ),
          const SizedBox(height: 50), // Extra space to prevent button overlap
        ],
      ),
    );
  }

  /// Helper method to build a main point with Hindi and English text.
  Widget _buildPoint(String number, String hindiText, String englishText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(hindiText),
              const SizedBox(height: 2),
              Text(englishText, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)),
            ],
          )),
        ],
      ),
    );
  }

  /// Helper method for the indented sub-points in question 4.
  Widget _buildSubPoint(String symbol, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(symbol),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}