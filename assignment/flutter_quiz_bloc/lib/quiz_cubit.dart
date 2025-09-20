// quiz_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quiz_state.dart';
import 'quiz_repository.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository repository;

  QuizCubit(this.repository) : super(QuizInitial());

  Future<void> fetchQuizzes({int count = 5}) async {
    emit(QuizLoading());
    try {
      final quizzes = await repository.fetchQuizzes(count: count);
      emit(QuizLoaded(quizzes: quizzes, currentIndex: 0));
    } catch (e) {
      emit(const QuizError('Failed to fetch quizzes'));
    }
  }

  void selectAnswer(int index) {
    if (state is QuizLoaded) {
      final s = state as QuizLoaded;
      emit(s.copyWith(selectedAnswer: index));
    }
  }

  void nextQuestion() {
    if (state is QuizLoaded) {
      final s = state as QuizLoaded;

      if (s.selectedAnswer == null) return; // prevent next if no answer

      int newScore = s.score;
      if (s.selectedAnswer == s.currentQuiz.correctAnswerIndex) {
        newScore++;
      }

      if (s.currentIndex < s.quizzes.length - 1) {
        emit(
          s.copyWith(
            currentIndex: s.currentIndex + 1,
            selectedAnswer: null,
            score: newScore,
          ),
        );
      } else {
        emit(
          QuizFinished(totalScore: newScore, totalQuestions: s.quizzes.length),
        );
      }
    }
  }

  void restartQuiz() {
    fetchQuizzes();
  }
}
