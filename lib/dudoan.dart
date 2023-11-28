import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'DuDoanScreen.dart';

class DuDoan extends StatefulWidget {
  const DuDoan({super.key, required this.title});

  final String title;

  @override
  State<DuDoan> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DuDoan> {
  late List<bool> _selected;
  late List<String> _itemTexts;
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
    _selected = List.generate(16, (index) => false);
    _itemTexts = [
      'LÔ 2 SỐ',
      'LÔ 2 SỐ 1K',
      'LÔ 3 SỐ',
      'LÔ 4 SỐ',
      '3 CÀNG ĐB',
      'XIÊN 3 ĐB',
      '4 CÀNG ĐB',
      'XIÊN 4 ĐB',
      'ĐỀ ĐẦU ĐUÔI',
      'ĐỀ GIẢI 7',
      'ĐỀ ĐẶC BIỆT',
      'ĐỀ GIẢI NHẤT',
      'ĐẦU ĐẶT BIỆT',
      'ĐẦU GIẢI NHẤT',
      'ĐUÔI ĐẶC BIỆT',
      'ĐUÔI GIẢI NHẤT',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/theme_home.png"),
            // Make sure this is the correct path to your background image
            fit: BoxFit.fill, // This will fill the background with the image
          ),
        ),
        child: Stack(
            // Your other widgets
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                // Căn giữa theo chiều ngang và đặt ở trên cùng
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  // Thêm padding phía trên 20 pixels
                  child: Text(
                    'CHỌN CHẾ ĐỘ',
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    onTap: () {
                      bool isAnyItemSelected = _selected.contains(true); // Check if any item is selected
                      if (isAnyItemSelected) {
                        // If any item is selected, navigate to the next screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DuDoanScreen()),
                        );
                      } else {
                        // If no item is selected, show a toast
                        Fluttertoast.showToast(
                            msg: "Vui lòng chọn giá trị lọc",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                    child: Image.asset(
                      "assets/img_dudoan.png",
                      width: 200,
                      height: 50,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 100),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns is 2
                    childAspectRatio: 3 / 1,
                  ),
                  itemCount: _selected.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selected[index] = !_selected[index];
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Color(0xFFFFE088)!, width: 1),
                          // Add border with specified color and width
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: _selected[index]
                            ?Color(0xFFFFE088)
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  color: _selected[index]
                                      ? Colors.brown
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  _itemTexts[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ]),
      ),
    );
  }
}
