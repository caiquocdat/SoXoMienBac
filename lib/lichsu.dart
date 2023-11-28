import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';


class LichSu extends StatefulWidget {
  const LichSu({super.key, required this.title});
  final String title;
  @override
  State<LichSu> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LichSu> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Màu trong suốt cho thanh trạng thái
      statusBarIconBrightness: Brightness.dark, // Màu sáng cho các biểu tượng trên thanh trạng thái
      systemNavigationBarColor: Colors.transparent,
    ));
  }
  String generateRandomNumbers() {
    Random random = Random();
    // Generate three random numbers (between 1 and 50, for example)
    int first = random.nextInt(98) + 1;
    int second = random.nextInt(98) + 1;
    int third = random.nextInt(98) + 1;
    // Return the numbers as a comma-separated string
    return "$first,$second,$third";
  }

  List<Map<String, dynamic>> generateData() {
    List<Map<String, dynamic>> generatedData = [];
    DateTime currentDate = DateTime.now();

    // Add "HÔM NAY" entry
    generatedData.add({
      'date': 'HÔM NAY', // Set the first item's date to "HÔM NAY"
      'numbers': [
        {'title': 'ĐỀ ĐẶC BIỆT', 'values': generateRandomNumbers()},
        {'title': 'XIÊN 3 ĐB', 'values': generateRandomNumbers()},
        {'title': 'XIÊN 4 ĐB', 'values': generateRandomNumbers()},
      ],
    });

    // Loop to create the rest of the data, starting with "yesterday"
    for (int i = 1; i < 5; i++) {
      // Subtract one more day for each iteration
      DateTime date = currentDate.subtract(Duration(days: i));
      String formattedDate = "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
      generatedData.add({
        'date': formattedDate,
        'numbers': [
          {'title': 'ĐỀ ĐẶC BIỆT', 'values': generateRandomNumbers()},
          {'title': 'XIÊN 3 ĐB', 'values': generateRandomNumbers()},
          {'title': 'XIÊN 4 ĐB', 'values': generateRandomNumbers()},
        ],
      });
    }
    return generatedData;
  }



  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = generateData();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/theme_home.png"), // Make sure this is the correct path to your background image
            fit: BoxFit.fill, // This will fill the background with the image
          ),
        ),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
                  borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0), // Adjust padding as needed
                      child: Text(
                        item['date'],
                        style: TextStyle(color: Colors.yellow, fontSize: 24),
                      ),
                    ),
                    ...item['numbers'].map<Widget>((numberSet) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              numberSet['title'],
                              style: TextStyle(color: Colors.yellow, fontSize: 18),
                            ),
                            Text(
                              numberSet['values'],
                              style: TextStyle(color: Colors.yellow, fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
