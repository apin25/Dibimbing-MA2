import 'package:day_21_state_management/presentation/provider/province_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvinceList extends StatelessWidget {
  const ProvinceList({super.key});

  @override
  Widget build(BuildContext context) {
    final provinceData = context.watch<ProvinceProvider>().state.provinces;

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      itemCount: provinceData.length,
      itemBuilder: (context, index) {
        final province = provinceData[index];
        return ListTile(
          title: Text(province.name),
          subtitle: Text('ID: ${province.id}'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
