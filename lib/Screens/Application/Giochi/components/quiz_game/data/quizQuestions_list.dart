import 'package:human_variable_behaviour/Screens/Application/Giochi/components/choice_screen/game_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/quiz_game/models/quizQuestion_model.dart';

List<QuizQuestionModel> quizQuestions = [
  QuizQuestionModel(
    listofQuestion[0],
    {
      listofAnswerQuestions[1]: false,
      listofAnswerQuestions[0]: true,
      listofAnswerQuestions[2]: false,
      listofAnswerQuestions[3]: false,
    },
  ),
  QuizQuestionModel(
    listofQuestion[1],
    {
      listofAnswerQuestions[4]: true,
      listofAnswerQuestions[5]: false,
      listofAnswerQuestions[6]: false,
      listofAnswerQuestions[7]: false,
    },
  ),
  QuizQuestionModel(
    listofQuestion[2],
    {
      listofAnswerQuestions[4]: true,
      listofAnswerQuestions[5]: false,
      listofAnswerQuestions[6]: false,
      listofAnswerQuestions[7]: false,
    },
  ),
  QuizQuestionModel(
    listofQuestion[3],
    {
      listofAnswerQuestions[9]: false,
      listofAnswerQuestions[10]: false,
      listofAnswerQuestions[8]: true,
      listofAnswerQuestions[11]: false,
    },
  ),
];
