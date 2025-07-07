import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:star_astro/common/utils/images.dart';


class PdfReportProvider with ChangeNotifier {
  List<PdfDemoModel> pdfDemoModel = [
    PdfDemoModel(
      id: 1,
      type: 1,
      pdfReportData: [
        PdfReportData(
          id: 1,
          image: Images.natalChart,
          title: "Natal Chart",
          description: demoDescription,
          price: "Coming Soon",
          currency: 1,
        ),
      ],
    ),
    PdfDemoModel(
      id: 2,
      type: 2,
      pdfReportData: [
        PdfReportData(
          id: 1,
          image: Images.lifeForecast,
          title: "Life Forecast",
          price: "Coming Soon",
          description: demoDescription,
        ),
        PdfReportData(
          id: 2,
          image: Images.solarReturn,
          title: "Solar Return",
          price: "Coming Soon",
          description: demoDescription,
        ),
      ],
    ),
    PdfDemoModel(
      id: 3,
      type: 1,
      pdfReportData: [
        PdfReportData(
          id: 1,
          image: Images.synastryReport,
          title: "Synastry Report",
          description: demoDescription,
          price: "Coming Soon",
        ),
      ],
    ),
  ];

  void onPdfReportItemClick(BuildContext context, PdfReportData pdfReportData) {
    context.push(
      '/pdf_download_screen',
      extra: pdfReportData,
    );
  }

  // onPdfReportItemClick(BuildContext context, PdfReportData pdfReportData) {
  //   context.router.push(PdfDownloadScreen(pdfReportData: pdfReportData));
  // }
}

class PdfDemoModel {
  int? id;
  int? type;
  List<PdfReportData>? pdfReportData;

  PdfDemoModel({this.id, this.type, this.pdfReportData});
}

class PdfReportData {
  int? id;
  String? title;
  String? image;
  String? description;
  dynamic price;
  int? currency;

  PdfReportData({
    this.id,
    this.title,
    this.image,
    this.description,
    this.price,
    this.currency,
  });
}

String demoDescription =
    "The natal chart is used in astrology to gain insights into a person's character, potential, and life path. Astrologers interpret the various elements of the chart to provide a detailed analysis of an individual's strengths, challenges, and tendencies. \nHere's a breakdown of what a natal chart includes and how it is used: \nSun Sign: Represents your core personality, ego, and essence.Moon Sign: Reflects your emotional nature and inner self.Rising Sign (Ascendant): Indicates your outward demeanor and how others perceive you.Planets in Signs: Each planet in the chart (e.g., Mercury, Venus, Mars) affects different aspects of your personality and life, depending on the sign it occupies.Houses: The chart is divided into 12 houses, each representing different areas of life (e.g., career, relationships, health).Aspects: These are the angles between planets, which influence how the planetary energies interact.The natal chart is used in astrology to gain insights into a person's character, potential, and life path. Astrologers interpret the various elements of the chart to provide a detailed analysis of an individual's strengths, challenges, and tendencies.The natal chart is used in astrology to gain insights into a person's character, potential, and life path. Astrologers interpret the various elements of the chart to provide a detailed analysis of an individual's strengths, challenges, and tendencies. \nHere's a breakdown of what a natal chart includes and how it is used: \nSun Sign: Represents your core personality, ego, and essence.Moon Sign: Reflects your emotional nature and inner self.Rising Sign (Ascendant): Indicates your outward demeanor and how others perceive you.Planets in Signs: Each planet in the chart (e.g., Mercury, Venus, Mars) affects different aspects of your personality and life, depending on the sign it occupies.Houses: The chart is divided into 12 houses, each representing different areas of life (e.g., career, relationships, health).Aspects: These are the angles between planets, which influence how the planetary energies interact.The natal chart is used in astrology to gain insights into a person's character, potential, and life path. Astrologers interpret the various elements of the chart to provide a detailed analysis of an individual's strengths, challenges, and tendencies.The natal chart is used in astrology to gain insights into a person's character, potential, and life path. Astrologers interpret the various elements of the chart to provide a detailed analysis of an individual's strengths, challenges, and tendencies. \nHere's a breakdown of what a natal chart includes and how it is used: \nSun Sign: Represents your core personality, ego, and essence.Moon Sign: Reflects your emotional nature and inner self.Rising Sign (Ascendant): Indicates your outward demeanor and how others perceive you.Planets in Signs: Each planet in the chart (e.g., Mercury, Venus, Mars) affects different aspects of your personality and life, depending on the sign it occupies.Houses: The chart is divided into 12 houses, each representing different areas of life (e.g., career, relationships, health).Aspects: These are the angles between planets, which influence how the planetary energies interact.The natal chart is used in astrology to gain insights into a person's character, potential, and life path. Astrologers interpret the various elements of the chart to provide a detailed analysis of an individual's strengths, challenges, and tendencies.The natal chart is used in astrology to gain insights into a person's character, potential, and life path. Astrologers interpret the various elements of the chart to provide a detailed analysis of an individual's strengths, challenges, and tendencies. \nHere's a breakdown of what a natal chart includes and how it is used: \nSun Sign: Represents your core personality, ego, and essence.Moon Sign: Reflects your emotional nature and inner self.Rising Sign (Ascendant): Indicates your outward demeanor and how others perceive you.Planets in Signs: Each planet in the chart (e.g., Mercury, Venus, Mars) affects different aspects of your personality and life, depending on the sign it occupies.Houses: The chart is divided into 12 houses, each representing different areas of life (e.g., career, relationships, health).Aspects: These are the angles between planets, which influence how the planetary energies interact.The natal chart is used in astrology to gain insights into a person's character, potential, and life path. Astrologers interpret the various elements of the chart to provide a detailed analysis of an individual's strengths, challenges, and tendencies.";
