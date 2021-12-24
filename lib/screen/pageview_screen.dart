import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController controller = PageController();
  var currentPageValue = 0.0;

@override
  void initState() {
    // TODO: implement initState
  controller.addListener(() {
    setState(() {
      currentPageValue = controller.page!;
  });
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemBuilder: (context, position) {

          return   Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? Colors.blue : Colors.pink,
              child: Center(
                child: Text(
                  "Page $position",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
