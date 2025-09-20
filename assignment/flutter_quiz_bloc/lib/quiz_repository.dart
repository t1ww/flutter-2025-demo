import 'dart:math';
import 'quiz_model.dart';

class QuizRepository {
  final Random _random = Random();

  final List<Quiz> _quizzes = [
    Quiz(
      question: "What is the name of the main protagonist in *Naruto*?",
      answers: [
        "Sasuke Uchiha",
        "Naruto Uzumaki",
        "Kakashi Hatake",
        "Itachi Uchiha",
      ],
      correctAnswerIndex: 1,
    ),
    Quiz(
      question: "In *Attack on Titan*, who is known as the Colossal Titan?",
      answers: [
        "Reiner Braun",
        "Zeke Yeager",
        "Bertholdt Hoover",
        "Annie Leonhart",
      ],
      correctAnswerIndex: 2,
    ),
    Quiz(
      question: "What is the name of L's real identity in *Death Note*?",
      answers: ["Light Yagami", "L Lawliet", "Near", "Ryuk"],
      correctAnswerIndex: 1,
    ),
    Quiz(
      question: "Which studio produced *Fullmetal Alchemist: Brotherhood*?",
      answers: ["MAPPA", "Studio Bones", "Sunrise", "Toei Animation"],
      correctAnswerIndex: 1,
    ),
    Quiz(
      question:
          "In *One Piece*, what is the name of Zoro’s signature three-sword style?",
      answers: ["Santoryu", "Nitoryu", "Shusui-ryu", "Tengenryu"],
      correctAnswerIndex: 0,
    ),
  ];

  // Fetch N random quizzes (default 5)
  Future<List<Quiz>> fetchQuizzes({int count = 5}) async {
    await Future.delayed(const Duration(seconds: 1));

    // shuffle and take first N
    final shuffled = List<Quiz>.from(_quizzes)..shuffle(_random);
    return shuffled.take(count).toList();
  }
}
