import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodels/floorplan_model.dart';
import 'view/screens/floorplan_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FloorPlanModel>(create: (context) => FloorPlanModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FloorPlanScreen(),
      ),
    );
  }
}
