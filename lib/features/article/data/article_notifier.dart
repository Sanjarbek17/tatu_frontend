import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_notifier.freezed.dart';

@freezed
class ArticleState with _$ArticleState {
  const factory ArticleState({
    @Default([]) List<String> articles,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _ArticleState;
}

class ArticleNotifier extends StateNotifier<ArticleState> {
  ArticleNotifier() : super(const ArticleState());

  void fetchArticles() async {
    state = state.copyWith(isLoading: true);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(articles: ['Article 1', 'Article 2'], isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }
}
