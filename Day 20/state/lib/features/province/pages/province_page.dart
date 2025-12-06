import 'package:flutter/material.dart';
import 'package:state/data/models/province_response.dart';
import 'package:state/data/repositories/province_repository.dart';

class ProvincePage extends StatefulWidget {
  const ProvincePage({super.key});

  @override
  State<ProvincePage> createState() => _ProvincePageState();
}

class _ProvincePageState extends State<ProvincePage> {
  bool _isLoading = false;
  List<ProvinceResponse> _provinceList = [];
  Future<void> _getProvinces() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final provinceRepository = ProvinceRepository();
      final provinceList = await provinceRepository.getProvince();

      if(provinceList.isNotEmpty){
        _provinceList.clear();
        _provinceList.addAll(provinceList);
      }
    } catch (e){
      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}