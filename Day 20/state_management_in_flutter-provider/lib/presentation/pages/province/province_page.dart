import 'package:day_21_state_management/presentation/pages/province/widgets/province_list.dart';
import 'package:day_21_state_management/presentation/provider/province_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvincePage extends StatefulWidget {
  const ProvincePage({super.key});

  @override
  State<ProvincePage> createState() => _ProvincePageState();
}

class _ProvincePageState extends State<ProvincePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProvinceProvider>().fetchProvinces();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProvinceProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Province Page')),
      body: provider.state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProvinceList(),
    );
  }
}
