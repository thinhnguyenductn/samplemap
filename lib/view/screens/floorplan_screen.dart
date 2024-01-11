import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/floorplan_model.dart';
import '../shared/global.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/gridview_widget.dart';
import '../widgets/overlay_widget.dart';
import '../widgets/raw_gesture_detector_widget.dart';
import '../widgets/reset_button_widget.dart';

class FloorPlanScreen extends StatelessWidget {
  const FloorPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBarWidget(),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          color: Global.blue,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                RawGestureDetectorWidget(
                  child: GridViewWidget(),
                ),
                model.hasTouched ? ResetButtonWidget() : OverlayWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
