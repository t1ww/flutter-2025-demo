// quiz_state.dart
import 'package:equatable/equatable.dart';
import 'quiz_model.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Quiz> quizzes;
  final int currentIndex;
  final int? selectedAnswer; // selected answer index for current question
  final int score; // current score

  const QuizLoaded({
    required this.quizzes,
    required this.currentIndex,
    this.selectedAnswer,
    this.score = 0,
  });

  Quiz get currentQuiz => quizzes[currentIndex];

  QuizLoaded copyWith({int? currentIndex, int? selectedAnswer, int? score}) {
    return QuizLoaded(
      quizzes: quizzes,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswer: selectedAnswer,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [quizzes, currentIndex, selectedAnswer, score];
}

class QuizFinished extends QuizState {
  final int totalScore;
  final int totalQuestions;

  const QuizFinished({required this.totalScore, required this.totalQuestions});

  @override
  List<Object?> get props => [totalScore, totalQuestions];
}

class QuizError extends QuizState {
  final String message;
  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
