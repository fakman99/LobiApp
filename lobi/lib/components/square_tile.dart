import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(offset: Offset(4, 4),spreadRadius: 1,blurRadius: 15,color: Colors.grey.shade500),
                    BoxShadow(offset: Offset(-4, -4),spreadRadius: 1,blurRadius: 15,color: Colors.white)

        ],
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffecf0f3),
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
