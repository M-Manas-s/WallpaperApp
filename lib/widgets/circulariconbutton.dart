import 'package:flutter/material.dart';
import 'package:wallpaperapp/constants/constants.dart';

class CircularIconButton extends StatelessWidget {
  Function()? onpressed;
  String iconname;
  IconData icon;

  CircularIconButton({this.onpressed,required this.iconname,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.purple,
          radius: 25.0,
          child: IconButton(
            onPressed: onpressed,
            icon: Icon(icon,color: Colors.white,)
          ),
        ),
        Text('$iconname',style: kIconButtonText,)
      ],
    );
  }
}
