import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_article_notifier.freezed.dart';

@freezed
class SubmitArticleState with _$SubmitArticleState {
  const factory SubmitArticleState({
    @Default(false) bool isSubmitting,
    @Default('') String errorMessage,
    @Default(false) bool isSuccess,
  }) = _SubmitArticleState;
}

class SubmitArticleNotifier extends StateNotifier<SubmitArticleState> {
  SubmitArticleNotifier() : super(const SubmitArticleState());

  Future<void> submitArticle(String articleContent) async {
    state = state.copyWith(isSubmitting: true);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(isSuccess: true, isSubmitting: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isSubmitting: false);
    }
  }
}
