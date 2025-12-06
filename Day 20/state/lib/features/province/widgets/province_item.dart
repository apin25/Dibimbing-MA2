import 'package:flutter/material.dart';
import 'package:state/data/models/province_response.dart';

class ProvinceItem extends StatelessWidget {
  const ProvinceItem({super.key, required this.province});

  final ProvinceResponse province;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:Text(province.name),
      subtitle: Text(province.id),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:BorderSide(color:Colors.grey.shade300)
      )
    );
  }
}