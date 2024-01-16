import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/models.dart';
import '../../core/path_finder/app_node.dart';
import '../../core/path_finder/astar_path_finder.dart';
import '../../core/path_finder/base_path_finder.dart';
import '../../core/path_finder/path_finder_painter.dart';
import '../../core/viewmodels/floorplan_model.dart';
import '../shared/global.dart';


const List<Offset> wallList = <Offset>[
  Offset(2, 1),
  Offset(3, 1),
  Offset(4, 1),
  Offset(5, 1),
  Offset(2, 4),
  Offset(3, 4),
  Offset(4, 4),
  Offset(5, 4),
  Offset(2, 7),
  Offset(3, 7),
  Offset(4, 7),
  Offset(5, 7),
  Offset(2, 10),
  Offset(3, 10),
  Offset(4, 10),
  Offset(5, 10),
  Offset(2, 13),
  Offset(3, 13),
  Offset(4, 13),
  Offset(5, 13),
  Offset(7, 4),
  Offset(8, 4),
];
const int size = 15;
const int walls = 10;

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);
    const Offset startPosition = Offset(8, 3);
    const Offset endPosition = Offset(4,6);

    final List<List<Node>> nodes =
    _generateNodes(size, wallList, startPosition, endPosition);


    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Global.blue,
              border: Border.all(color: Global.blue2,width: 1)
          ),

          child: Image.asset(
            'images/tile_01.png',
          ),
        ),
        SizedBox(
          width: screenSize.width,
          height: screenSize.width,
          child: _drawMap(
            Node.cloneList(nodes),
            AStarPathFinder(),
            startPosition,
            endPosition,
          ),
        ),
        // model.isScaled ?
        // Stack(
        //         children: List.generate(
        //           tileLights.length,
        //           (idx) {
        //             return Transform.translate(
        //               offset: Offset(
        //                 size.width * tileLights[idx].position![0],
        //                   size.width * tileLights[idx].position![1],
        //               ),
        //               child: Stack(
        //                 alignment: Alignment.topLeft,
        //                 children: <Widget>[
        //                   CircleAvatar(
        //                     backgroundColor: tileLights[idx].status! ? Colors.greenAccent : Colors.white,
        //                     radius: 5.0,
        //                     child: const Center(
        //                       child: Icon(
        //                         Icons.lightbulb_outline,
        //                         color: Global.blue,
        //                         size: 7,
        //                       ),
        //                     ),
        //                   ),
        //                   // Transform(
        //                   //   transform: Matrix4.identity()..translate(18.0),
        //                   //   child: Text(
        //                   //     tileLights[idx].name!,
        //                   //     style: const TextStyle(
        //                   //       fontSize: 6.0,
        //                   //       color: Colors.white,
        //                   //     ),
        //                   //   ),
        //                   // )
        //                 ],
        //               ),
        //             );
        //           },
        //         ),
        //       )
        // : CircleAvatar(
        //     backgroundColor: Colors.white,
        //     child: Text(
        //       '${tileLights.length}',
        //       style: TextStyle(
        //         color: Global.blue,
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  Widget _drawMap(
      List<List<Node>> nodes,
      BasePathFinder pathFinder,
      Offset startPosition,
      Offset endPosition,
      ) {
    final int startX = startPosition.dx.floor();
    final int startY = startPosition.dy.floor();

    final int endX = endPosition.dx.floor();
    final int endY = endPosition.dy.floor();

    final Node start = nodes[startX][startY];
    final Node end = nodes[endX][endY];

    return Column(
      children: <Widget>[
        StreamBuilder<List<List<Node>>>(
          stream: pathFinder(nodes, start, end),
          initialData: nodes,
          builder: (
              BuildContext context,
              AsyncSnapshot<List<List<Node>>> finderSnapshot,
              ) =>
              StreamBuilder<List<Node>>(
                stream: pathFinder.getPath(end),
                initialData: const <Node>[],
                builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Node>> pathSnapshot,
                    ) =>
                    CustomPaint(
                      size: const Size(350, 350),
                      painter: PathFinderPainter(
                        finderSnapshot.data!,
                        pathSnapshot.data!,
                        start,
                        end,
                      ),
                    ),
              ),
        ),
      ],
    );
  }

  List<List<Node>> _generateNodes(
      int size,
      List<Offset> wallList,
      Offset start,
      Offset end,
      ) {
    final List<List<Node>> nodes = <List<Node>>[];

    for (int i = 0; i < size; i++) {
      final List<Node> row = <Node>[];

      for (int j = 0; j < size; j++) {
        row.add(Node(Offset(j.toDouble(), i.toDouble())));
      }

      nodes.add(row);
    }

    //Generate random wall
    // for (int i = 0; i < walls; i++) {
    //   final int row = Random().nextInt(size);
    //   final int column = Random().nextInt(size);
    //
    //   final int startX = start.dx.floor();
    //   final int startY = start.dy.floor();
    //
    //   final int endX = end.dx.floor();
    //   final int endY = end.dy.floor();
    //
    //   //Skip this turn and continue looping if auto generated wall is on the start or end.
    //   if (nodes[row][column] == nodes[startY][startX] ||
    //       nodes[row][column] == nodes[endY][endX]) {
    //     i--;
    //     continue;
    //   }
    //
    //   nodes[row][column].isWall = true;
    // }

    for (final Offset wall in wallList) {
      nodes[wall.dx.floor()][wall.dy.floor()].isWall = true;
    }

    return nodes;
  }
}
