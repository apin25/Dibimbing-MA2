import 'package:flutter/material.dart';

class AdaptiveScreen extends StatelessWidget {
  const AdaptiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.of(context).textScaler;

    return Scaffold(
      appBar: AppBar(title: Text('Adaptive Layout')),
      body: LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < 600){
            return MobileLayout(textScaler: textScaler);
          } else if (constraints.maxWidth < 1200){
            return TabletLayout(textScaler: textScaler);
          } else {
            return DesktopLayout(textScaler: textScaler);
          }
        },
      ),
    );
  }
}
class MobileLayout extends StatelessWidget {
  final TextScaler textScaler;

  const MobileLayout({super.key, required this.textScaler});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        AdaptiveCard(
          color: Colors.blue,
          label: 'Mobile Item 1',
          textScaler: textScaler
        ),
        AdaptiveCard(
          color: Colors.green,
          label: 'Mobile Item 2',
          textScaler: textScaler
        ),
      ],
    );
  }
}
class TabletLayout extends StatelessWidget {
  final TextScaler textScaler;

  const TabletLayout({super.key, required this.textScaler});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AdaptiveCard(
          color: Colors.blue,
          label: 'Tablet Item 1',
          textScaler: textScaler
          ),
        ),
        Expanded(
          child: AdaptiveCard(
          color: Colors.blue,
          label: 'Tablet Item 2',
          textScaler: textScaler
          ),
        ),
      ],
    );
  }
}
class DesktopLayout extends StatelessWidget {
  final TextScaler textScaler;

  const DesktopLayout({super.key, required this.textScaler});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AdaptiveCard(
          color: Colors.blue,
          label: 'Desktop Item 1',
          textScaler: textScaler
          ),
        ),
        Expanded(
          child: AdaptiveCard(
          color: Colors.blue,
          label: 'Desktop Item 2',
          textScaler: textScaler
          ),
        ),
        Expanded(
          child: AdaptiveCard(
          color: Colors.orange,
          label: 'Desktop Item 3',
          textScaler: textScaler
          ),
        ),
      ],
    );
  }
}
class AdaptiveCard extends StatelessWidget {
  final Color color;
  final String label;
  final TextScaler textScaler;

  const AdaptiveCard({super.key, required this.color, required this.label, required this.textScaler});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      color: color.withValues(alpha: 0.9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.devices, size: screenWidth * 0.1, color: Colors.white),
          SizedBox(height: 16),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textScaler: textScaler,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}