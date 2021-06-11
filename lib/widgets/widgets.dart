import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: const <TextSpan>[
        TextSpan(
            text: 'Brain',
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
        TextSpan(
            text: 'Quiz',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
      ],
    ),
  );
}

Widget blueButton({required BuildContext context, required String label,buttonWidth}) {
  return Container(
      // padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      height: 50,
      width: buttonWidth!=null? buttonWidth:MediaQuery.of(context).size.width - 48,
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 16)));
}
