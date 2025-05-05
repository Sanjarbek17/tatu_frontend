import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexNotifier extends StateNotifier<int> {
  IndexNotifier() : super(0);

  void setIndex(int newIndex) {
    state = newIndex;
  }
}

final indexProvider = StateNotifierProvider<IndexNotifier, int>((ref) {
  return IndexNotifier();
});