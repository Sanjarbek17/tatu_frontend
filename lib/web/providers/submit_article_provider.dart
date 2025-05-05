import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../constants.dart';
import 'auth_provider.dart';

class SubmitArticleState {
  final bool isLoading;
  final String? error;

  SubmitArticleState({this.isLoading = false, this.error});

  SubmitArticleState copyWith({bool? isLoading, String? error}) {
    return SubmitArticleState(isLoading: isLoading ?? this.isLoading, error: error);
  }
}

class SubmitArticleNotifier extends StateNotifier<SubmitArticleState> {
  final Ref _ref;

  SubmitArticleNotifier(this._ref) : super(SubmitArticleState());

  Future<void> submitArticle(String title, String description, String filePath) async {
    state = state.copyWith(isLoading: true);
    final authState = _ref.read(authProvider);

    if (authState.token == null) {
      state = state.copyWith(isLoading: false, error: 'User not authenticated.');
      return;
    }

    final dio = Dio();
    final url = '$baseUrl/api/articles/';

    try {
      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer ${authState.token}'}),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to submit article.');
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final submitArticleProvider = StateNotifierProvider<SubmitArticleNotifier, SubmitArticleState>(
  (ref) => SubmitArticleNotifier(ref),
);
