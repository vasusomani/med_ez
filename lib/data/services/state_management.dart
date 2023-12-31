import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_ez/data/models/api_res_model.dart';

class IdNotifier extends StateNotifier<String> {
  IdNotifier() : super("");
  void changeId(String id) {
    state = id;
  }
}

final idProvider =
    StateNotifierProvider<IdNotifier, String>((ref) => IdNotifier());

class DataNotifier extends StateNotifier<ApiResponse?> {
  DataNotifier() : super(null);
  void updateData(ApiResponse? data) {
    if (data != null) {
      state = data;
    }
  }
}

final dataProvider =
    StateNotifierProvider<DataNotifier, ApiResponse?>((ref) => DataNotifier());
