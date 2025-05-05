import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_article_notifier.freezed.dart';

@freezed
class StudentArticleState with _$StudentArticleState {
  const factory StudentArticleState({
    @Default([]) List<String> studentArticles,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _StudentArticleState;
}

class StudentArticleNotifier extends StateNotifier<StudentArticleState> {
  StudentArticleNotifier() : super(const StudentArticleState());

  void fetchStudentArticles() async {
    state = state.copyWith(isLoading: true);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(
        studentArticles: ['Student Article 1', 'Student Article 2'],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }
}
