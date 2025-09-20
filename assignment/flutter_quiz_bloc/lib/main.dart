// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quiz_cubit.dart';
import 'quiz_state.dart';
import 'quiz_repository.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final QuizRepository repository = QuizRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => QuizCubit(repository),
        child: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anime Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is QuizInitial) {
              return Center(
                child: ElevatedButton(
                  onPressed: () => context.read<QuizCubit>().fetchQuizzes(),
                  child: const Text("Start Quiz"),
                ),
              );
            } else if (state is QuizLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuizLoaded) {
              final quiz = state.currentQuiz;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Q${state.currentIndex + 1}: ${quiz.question}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...quiz.answers.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final answer = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<QuizCubit>().selectAnswer(idx);
                          context.read<QuizCubit>().nextQuestion();
                        },
                        child: Text(answer),
                      ),
                    );
                  }),
                  const Spacer(),
                  Text(
                    "Question ${state.currentIndex + 1}/${state.quizzes.length}",
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else if (state is QuizFinished) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You scored ${state.totalScore} / ${state.totalQuestions}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.read<QuizCubit>().restartQuiz(),
                      child: const Text("Restart Quiz"),
                    ),
                  ],
                ),
              );
            } else if (state is QuizError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
