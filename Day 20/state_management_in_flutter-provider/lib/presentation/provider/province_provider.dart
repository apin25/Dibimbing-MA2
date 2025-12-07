import 'package:day_21_state_management/data/model/province_response.dart';
import 'package:day_21_state_management/data/repository/data_repository.dart';
import 'package:flutter/material.dart';

class ProvinceState {
  final bool isLoading;
  final List<ProvinceResponse> provinces;
  final String? errorMessage;

  ProvinceState({
    this.isLoading = false,
    required this.provinces,
    this.errorMessage,
  });

  ProvinceState copyWith({
    bool? isLoading,
    List<ProvinceResponse>? provinces,
    String? errorMessage,
  }) {
    return ProvinceState(
      isLoading: isLoading ?? this.isLoading,
      provinces: provinces ?? this.provinces,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ProvinceProvider extends ChangeNotifier {
  final DataRepository repository;
  ProvinceProvider({required this.repository});

  // List<ProvinceResponse> _provinces = [];
  // bool _isLoading = false;
  // String? _errorMessage;
  ProvinceState state = ProvinceState(provinces: []);

  // List<ProvinceResponse> get provinces => state.provinces;
  // bool get isLoading => state.isLoading;
  // String? get errorMessage => state.errorMessage;

  Future<void> fetchProvinces() async {
    state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final response = await repository.fetchProvinces();

      state = state.copyWith(provinces: response);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
