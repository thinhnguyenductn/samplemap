import 'package:flutter/material.dart';

import '../shared/global.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Column(
          children: const <Widget>[
            Text(
              'Floor Plan Screen',
              style: TextStyle(
                color: Global.blue,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Global.blue,
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
