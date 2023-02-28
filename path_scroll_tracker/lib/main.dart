import 'package:flutter/material.dart';
import 'package:path_scroll_tracker/widgets/circle_shape_tracking/circle_shape_tracking.dart';
import 'package:path_scroll_tracker/widgets/randome_images.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ctx = ScrollController();
  late final ValueNotifier<double> m;

  @override
  void initState() {
    super.initState();
    m = ValueNotifier<double>(0);
    ctx.addListener(() {
      // print(ctx.offset);

      m.value = ctx.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Container(
          child: Scrollbar(
            controller: ctx,
            thickness: 10,
            thumbVisibility: true,
            trackVisibility: false,
            radius: const Radius.circular(5),
            interactive: true,
            notificationPredicate: (notification) {
              m.value = notification.metrics.viewportDimension *
                  (notification.metrics.pixels /
                      notification.metrics.maxScrollExtent);
              // m.value = (notification.metrics.pixels /
              //     notification.metrics.maxScrollExtent);

              // = notification.metrics.pixels;
              print(m.value);

              return true;
            },
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ListView.builder(
                  controller: ctx,
                  itemBuilder: (context, index) {
                    return RandomImage(
                      index: index,
                      height: 300,
                    );
                  },
                  itemCount: 40,
                ),
                ValueListenableBuilder(
                    valueListenable: m,
                    builder: (context, value, _) {
                      return Positioned(
                          right: 50,
                          top: value * 50,
                          // alignment: Alignment(0.8, -1 + value),
                          // height: 20,

                          child: const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircleShapeTracking()));
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
