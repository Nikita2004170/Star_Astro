import 'package:flutter/material.dart';
import 'package:star_astro/lib/screens/horoscope/daily_horoscope/daily_horoscope.dart';

class HoroscopeSelectionScreen extends StatefulWidget {
  const HoroscopeSelectionScreen({super.key});

  @override
  State<HoroscopeSelectionScreen> createState() =>
      _HoroscopeSelectionScreenState();
}

class _HoroscopeSelectionScreenState extends State<HoroscopeSelectionScreen> {
  String selectedAstrology = '';
  String selectedZodiac = '';
  String selectedTimezone = 'IST (UTC +5:30)';

  final List<Map<String, dynamic>> zodiacSigns = [
    {'name': 'Aries', 'icon': '♈', 'color': Color(0xFFE74C3C)},
    {'name': 'Taurus', 'icon': '♉', 'color': Color(0xFFE67E22)},
    {'name': 'Gemini', 'icon': '♊', 'color': Color(0xFFF39C12)},
    {'name': 'Cancer', 'icon': '♋', 'color': Color(0xFFF1C40F)},
    {'name': 'Leo', 'icon': '♌', 'color': Color(0xFFF1C40F)},
    {'name': 'Virgo', 'icon': '♍', 'color': Color(0xFF2ECC71)},
    {'name': 'Libra', 'icon': '♎', 'color': Color(0xFF1ABC9C)},
    {'name': 'Scorpio', 'icon': '♏', 'color': Color(0xFF16A085)},
    {'name': 'Sagittarius', 'icon': '♐', 'color': Color(0xFF3498DB)},
    {'name': 'Capricorn', 'icon': '♑', 'color': Color(0xFF9B59B6)},
    {'name': 'Aquarius', 'icon': '♒', 'color': Color(0xFF8E44AD)},
    {'name': 'Pisces', 'icon': '♓', 'color': Color(0xFFE91E63)},
  ];

  final List<String> timezones = [
    'IST (UTC +5:30)',
    'PST (UTC -8:00)',
    'EST (UTC -5:00)',
    'GMT (UTC +0:00)',
    'CET (UTC +1:00)',
    'JST (UTC +9:00)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[400]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.menu, color: Colors.grey[400]),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Center(
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Color(0xFF4A90E2),
                        Color.fromARGB(255, 170, 97, 230),
                        // Color(0xFF2E5A8A),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ).createShader(bounds),
                    child: Text(
                      'Today\'s\nHoroscope',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Discover what the stars have in\nstore for you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // Astrology System Section
            Text(
              'Astrology System',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAstrology = 'Vedic';
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: selectedAstrology == 'Vedic'
                            ? Color.fromARGB(255, 35, 36, 37)
                            : Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedAstrology == 'Vedic'
                              ? Color(0xFF4A90E2)
                              : Color(0xFF3C3C3E),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedAstrology == 'Vedic'
                                  ? Colors.white
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedAstrology == 'Vedic'
                                    ? Colors.white
                                    : Colors.grey[400]!,
                                width: 2,
                              ),
                            ),
                            child: selectedAstrology == 'Vedic'
                                ? Center(
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF4A90E2),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Vedic',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAstrology = 'Western';
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: selectedAstrology == 'Western'
                            ? Color.fromARGB(255, 35, 36, 37)
                            : Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedAstrology == 'Western'
                              ? Color(0xFF4A90E2)
                              : Color(0xFF3C3C3E),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedAstrology == 'Western'
                                  ? Colors.white
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedAstrology == 'Western'
                                    ? Colors.white
                                    : Colors.grey[400]!,
                                width: 2,
                              ),
                            ),
                            child: selectedAstrology == 'Western'
                                ? Center(
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF4A90E2),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Western',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),

            // Zodiac Sign Section
            Text(
              'Your Zodiac Sign',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
              ),
              itemCount: zodiacSigns.length,
              itemBuilder: (context, index) {
                final zodiac = zodiacSigns[index];
                final isSelected = selectedZodiac == zodiac['name'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedZodiac = zodiac['name'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            isSelected ? Color(0xFF4A90E2) : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: zodiac['color'],
                          ),
                          child: Center(
                            child: Text(
                              zodiac['icon'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          zodiac['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 32),

            // Timezone Section
            Text(
              'Timezone',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF3C3C3E),
                  width: 1,
                ),
              ),
              child: DropdownButton<String>(
                value: selectedTimezone,
                isExpanded: true,
                underline: SizedBox(),
                dropdownColor: Color(0xFF2C2C2E),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[400],
                ),
                items: timezones.map((String timezone) {
                  return DropdownMenuItem<String>(
                    value: timezone,
                    child: Text(timezone),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedTimezone = newValue;
                    });
                  }
                },
              ),
            ),

            SizedBox(height: 40),

            // Get Today's Horoscope Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedZodiac.isNotEmpty
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DailyHoroscopeScreen(
                                    astrologySystem: selectedAstrology,
                                    zodiacSign: selectedZodiac,
                                    timezone: selectedTimezone)));
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A90E2),
                  disabledBackgroundColor: Colors.grey[600],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Get Today\'s Horoscope',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
