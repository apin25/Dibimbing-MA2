import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(title: Text('Media Query + LAyout Builder')),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: LayoutBuilder(
          builder: (context, constrains){
            if(constrains.maxWidth < 600){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildBox(Colors.blue, screenSize.width),
                    SizedBox(height: 20),
                    buildBox(Colors.green, screenSize.width),
                  ],
                )
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildBox(Colors.blue, screenSize.width / 2),
                  buildBox(Colors.green, screenSize.width / 2),
                ],
              );
            }
          }
        )
      )
    );
  }

  Widget buildBox(Color color, double width){
    return Container(
      width: width * 0.8,
      height: 150,
      color : color,
      child: Center(
        child: Text('Box', style: TextStyle(color: Colors.white, fontSize: 24)),
      )
    );
  }
}