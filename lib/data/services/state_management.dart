import 'package:flutter_riverpod/flutter_riverpod.dart';

class IdNotifier extends StateNotifier<String> {
  IdNotifier() : super("");
  void changeId(String id) {
    state = id;
  }
}

final idProvider =
    StateNotifierProvider<IdNotifier, String>((ref) => IdNotifier());
