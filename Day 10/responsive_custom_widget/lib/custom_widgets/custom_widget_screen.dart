import 'package:flutter/material.dart';
import 'package:responsive_custom_widget/custom_widgets/custom_button.dart';
import 'package:responsive_custom_widget/custom_widgets/custom_card.dart';

class MyCustomWidgetScreen extends StatelessWidget {
  const MyCustomWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomButton(
              label: "Hello", 
              color: Colors.red, 
              onTap: () => print("button press"),
            ),
            SizedBox(height:10),
            ElevatedButton(
              onPressed: () => 1, 
              child: Text("Submit"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                MyCustomCard(), 
                MyCustomCard()
              ],
            ),
          ],
        )
      )
    );
  }
}