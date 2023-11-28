import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HexagonTile.dart';
import 'dart:math';

class DuDoanScreen extends StatefulWidget {
  @override
  _DuDoanScreenState createState() => _DuDoanScreenState();
}

class _DuDoanScreenState extends State<DuDoanScreen> {
  Duration duration = Duration(
      hours: 0, minutes: 20, seconds: 0); // Set initial countdown duration
  Timer? countdownTimer;
  late String randomNumber1;
  late String randomNumber2;
  late String randomNumber3;
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final targetTimeToday = DateTime(now.year, now.month, now.day, 17);
    final targetTimeTomorrow = targetTimeToday.add(Duration(days: 1));

    if (now.isBefore(targetTimeToday)) {
      duration = targetTimeToday.difference(now);
    } else {
      duration = targetTimeTomorrow.difference(now);
    }

    startTimer();
    randomNumber1 = generateRandomNumber();
    randomNumber2 = generateRandomNumber();
    randomNumber3 = generateRandomNumber();
  }
  String generateRandomNumber() {
    Random random = new Random();
    int number = random.nextInt(90) + 10; // Generates a number between 10 and 99
    return number.toString();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountdown());
  }

  void setCountdown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = duration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  Widget _buildTimeBox(String time, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFFE088),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Scaffold(
      body: Stack(
        children: [
          // Add background
          Container(
            decoration: BoxDecoration(
              // Assuming you want to use an image as the background
              image: DecorationImage(
                image: AssetImage("assets/img_theme_splash.png"),
                fit: BoxFit
                    .cover, // This will fill the background with the image
              ),
            ),
          ),
          // Positioned image with margins
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // This will handle the back action
              },
              child: Image.asset(
                "assets/img_back.png", // Replace with your image asset path
                width: 150,
                height: 50,
              ),
            ),
          ),
          // Other widgets can be added here
          Positioned(
            top: 100, // Margin top 100
            left: 20, // Margin left 20
            right: 20,
            child: Container(
              padding: EdgeInsets.all(10), // Padding inside the container
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                // Background color of the container
                borderRadius: BorderRadius.circular(10),
                // Border radius of the container
                border: Border.all(
                    color: Colors.white, width: 1), // White border with width 1
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Dự đoán text
                  Text(
                    'Dự Đoán Lô Đề Miền Bắc Đóng Lại Sau',
                    textAlign: TextAlign.center, // Center align text
                    style: TextStyle(
                      color: Colors.white, // Set your color
                      fontSize: 18, // Set your font size
                      fontWeight: FontWeight.bold, // Set your font weight
                      fontFamily: 'RedReg',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Countdown timer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hours
                      _buildTimeBox(hours, 'Giờ'),
                      SizedBox(width: 8),
                      // Minutes
                      _buildTimeBox(minutes, 'Phút'),
                      SizedBox(width: 8),
                      // Seconds
                      _buildTimeBox(seconds, 'Giây'),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Disclaimer note
                  Text(
                    'Lưu ý: các dự đoán được tính toán nhờ tích hợp trí tuệ Ai và tổng hợp các dữ liệu kết quả cũ. Kết quả chỉ mang tính chất tham khảo.',
                    textAlign: TextAlign.center, // Center align text
                    style: TextStyle(
                      color: Colors.white, // Set your color
                      fontSize: 14, // Set your font size
                      fontFamily: 'RedReg',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 0,
            right: 0, // This will ensure the Container takes full width
            child: Container(
              color: Color(0xFFFFE088), // Màu nền vàng cho Container
              alignment: Alignment.center, // Căn giữa nội dung của Container
              child: Text(
                'CON SỐ MAY MẮN HÔM NAY LÀ:',
                textAlign: TextAlign.center, // Căn giữa văn bản
                style: TextStyle(
                  fontSize: 24, // Cỡ chữ cho văn bản
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RedBold' // Độ đậm cho văn bản
                  // Other text styles if needed
                ),
              ),
            ),
          ),
          Positioned(
            top: 320,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(height: 100),
                    HexagonTile(number: randomNumber1), // The bottom-left hexagon
                    // Space between hexagons
                  ],
                ),
                SizedBox(width: 0), // Space between hexagon columns
                HexagonTile(number: randomNumber2), // The top-center hexagon
                SizedBox(width: 0), // Space between hexagon columns
                Column(
                  children: [
                    SizedBox(height: 100), // Space to move the bottom-right hexagon down
                    HexagonTile(number: randomNumber3), // The bottom-right hexagon
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
