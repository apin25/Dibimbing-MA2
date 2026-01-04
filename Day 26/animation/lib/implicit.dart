import 'package:flutter/material.dart';

class ImplicitPage extends StatelessWidget {
  const ImplicitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Implicit Animation"),
      ),
      body: const Center(
        child: AnimatedBox(),
      ),
    );
  }
}

class AnimatedBox extends StatefulWidget {
  const AnimatedBox({super.key});

  @override
  State<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  void _animate() {
    setState(() {
      _width = _width == 100 ? 200 : 100;
      _height = _height == 100 ? 200 : 100;
      _color = _color == Colors.blue ? Colors.red : Colors.blue;
      _borderRadius = _borderRadius == BorderRadius.circular(8)
          ? BorderRadius.circular(50)
          : BorderRadius.circular(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          duration: const Duration(seconds:1),
          curve: Curves.fastOutSlowIn,
        ),
        const SizedBox(height: 20),
        Stack(
          children: [
            Positioned.fill(child: Center(child:Text('Hello'))),
            AnimatedOpacity(
              opacity: _color == Colors.blue ? 1.0 : 0.3, 
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Container(width:100, height:100, color:Colors.green)
            )
          ],
        ),
        const SizedBox(height:20),
        AnimatedAlign(
          alignment: _color == Colors.blue ? Alignment.center : Alignment.topRight, 
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child:Container(width: 100, height: 100, color : Colors.yellow)
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: _animate, child: const Text('Animate!')),
      ],
    );
  }
}
