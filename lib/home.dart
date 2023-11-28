import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lichsu.dart';
import 'ketqua.dart';
import 'dudoan.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Set your color or use Theme.of(context).primaryColor
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          // Color for selected tab items (icon and text)
          unselectedLabelColor: Colors.grey,
          // Color for unselected tab items (icon and text)
          tabs: [
            Tab(icon: Icon(Icons.history), text: 'Lịch sử'),
            Tab(icon: Icon(Icons.ac_unit), text: 'Dự đoán'),
            Tab(icon: Icon(Icons.send_and_archive), text: 'Kết quả'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LichSu(title: 'lichsu',),
          DuDoan(title: 'dudoan'),
          KetQua(title: 'ketqua',),
        ],
      ),
    );
  }
}
