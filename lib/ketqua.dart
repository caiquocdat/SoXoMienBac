import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class KetQua extends StatefulWidget {
  const KetQua({super.key, required this.title});

  final String title;

  @override
  State<KetQua> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<KetQua> {
  DateTime selectedDate = DateTime.now();

  void _decrementDate() {
    setState(() {
      selectedDate = selectedDate.subtract(Duration(days: 1));
    });
  }

  void _incrementDate() {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: 1));
    });
  }

  String _getWeekday(DateTime date) {
    // You can customize the function to return the weekday in your preferred language
    List<String> weekdays = [
      'Chủ Nhật',
      'Thứ Hai',
      'Thứ Ba',
      'Thứ Tư',
      'Thứ Năm',
      'Thứ Sáu',
      'Thứ Bảy'
    ];
    return weekdays[date.weekday % 7];
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // Màu trong suốt cho thanh trạng thái
      statusBarIconBrightness: Brightness.dark,
      // Màu sáng cho các biểu tượng trên thanh trạng thái
      systemNavigationBarColor: Colors.transparent,
    ));
  }

  Widget _buildPrizeCategory(String title, List<String> numbers) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // The yellow color background
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
                border: Border.all(
                    color: Color(0xFFFFE088), width: 1), // White border
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Expanded(
            child: Container(
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // The yellow color background
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
                border: Border.all(
                    color: Color(0xFFFFE088), width: 1), // White border
              ),
              child: Text(
                numbers.join('    '), // Join numbers with spaces
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
  String _generateRandomNumber() {
    var rng = Random();
    // Generate a random number between 10000 and 99999
    int number = rng.nextInt(90000) + 10000;
    return number.toString();
  }

  List<String> _generateRandomNumbers(int count) {
    return List<String>.generate(count, (_) => _generateRandomNumber());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img_theme_splash.png"),
              // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                // Căn giữa theo chiều ngang và đặt ở trên cùng
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  // Thêm padding phía trên 20 pixels
                  child: Text(
                    'KẾT QUẢ LÔ ĐỀ MB',
                    style: TextStyle(
                      color: Color(0xFFFFE088),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontFamily: 'RedBold',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                // This adds a 60-pixel gap after your text
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  // Add padding inside the container if needed
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE088),
                    // Change this to the color you want
                    borderRadius: BorderRadius.circular(30.0),
                    // The radius of the corners
                    border: Border.all(
                      color: Colors.white, // The color of the border
                      width: 1.0, // The width of the border
                    ),
                  ),
                  child: IntrinsicHeight(
                    // Use IntrinsicHeight for equal heights of elements inside Row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          iconSize: 40.0,
                          onPressed: _decrementDate,
                        ),
                        Text(
                          '${_getWeekday(selectedDate)}, ${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_right),
                          iconSize: 40.0,
                          onPressed: _incrementDate,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 140, left: 20, right: 20),
                child: ListView(
                  children: <Widget>[
                    // Use a loop or a method to generate these containers based on your data
                    _buildPrizeCategory('GIẢI ĐB', _generateRandomNumbers(1)),
                    _buildPrizeCategory('GIẢI NHẤT', _generateRandomNumbers(1)),
                    _buildPrizeCategory('GIẢI NHÌ', _generateRandomNumbers(2)),
                    _buildPrizeCategory('GIẢI BA', _generateRandomNumbers(6)),
                    _buildPrizeCategory('GIẢI TƯ', _generateRandomNumbers(4)),
                    _buildPrizeCategory('GIẢI NĂM', _generateRandomNumbers(6)),
                    _buildPrizeCategory('GIẢI SÁU', _generateRandomNumbers(3)),
                    _buildPrizeCategory('GIẢI BẢY', _generateRandomNumbers(4)),
                    // ... Add more categories as needed
                  ],
                ),
              )
              // ... Thêm các widget khác ở đây
            ],
          )),
    );
  }
}
