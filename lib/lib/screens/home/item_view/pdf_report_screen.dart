import 'package:flutter/material.dart';
import 'package:star_astro/common/utils/images.dart';
import 'package:star_astro/common/utils/colors.dart';

class PdfReportScreen extends StatelessWidget {
  const PdfReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SDColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: SDColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'PDF REPORT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Images.natalChart,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            const Text(
              'Coming Soon',
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          Images.lifeForecast,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: 160,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Coming Soon',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          Images.solarReturn,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: 160,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Coming Soon',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Images.synastryReport,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            const Text(
              'Coming Soon',
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
