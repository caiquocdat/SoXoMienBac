import 'package:flutter/cupertino.dart';

class HexagonTile extends StatelessWidget {
  final String number;
  final double size;

  HexagonTile({required this.number, this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        // Use an image of a hexagon
        image: DecorationImage(
          image: AssetImage('assets/hexagon_image.png'), // Path to your hexagon image
          fit: BoxFit.fill,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: TextStyle(
          color: Color(0xFF000000),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}