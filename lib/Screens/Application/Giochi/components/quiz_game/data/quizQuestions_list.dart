import 'package:human_variable_behaviour/Screens/Application/Giochi/components/choice_screen/game_screen.dart';
import 'package:human_variable_behaviour/Screens/Application/Giochi/components/quiz_game/models/quizQuestion_model.dart';

List<QuizQuestionModel> quizQuestions = [
  QuizQuestionModel(
    listofQuestion[rndNum.elementAt(0)],
    {
      listofAnswerQuestions[(rndNum.elementAt(0)*4)+1]: false,
      listofAnswerQuestions[(rndNum.elementAt(0)*4)]: true,
      listofAnswerQuestions[(rndNum.elementAt(0)*4)+2]: false,
      listofAnswerQuestions[(rndNum.elementAt(0)*4)+3]: false,
    },
  ),
  QuizQuestionModel(
    listofQuestion[rndNum.elementAt(1)],
    {
      listofAnswerQuestions[(rndNum.elementAt(1)*4)]: true,
      listofAnswerQuestions[(rndNum.elementAt(1)*4)+1]: false,
      listofAnswerQuestions[(rndNum.elementAt(1)*4)+2]: false,
      listofAnswerQuestions[(rndNum.elementAt(1)*4)+3]: false,
    },
  ),
  QuizQuestionModel(
    listofQuestion[rndNum.elementAt(2)],
    {
      listofAnswerQuestions[(rndNum.elementAt(2)*4)+1]: false,
      listofAnswerQuestions[(rndNum.elementAt(2)*4)+2]: false,
      listofAnswerQuestions[(rndNum.elementAt(2)*4)]: true,
      listofAnswerQuestions[(rndNum.elementAt(2)*4)+3]: false,
    },
  ),
  QuizQuestionModel(
    listofQuestion[rndNum.elementAt(3)],
    {
      listofAnswerQuestions[(rndNum.elementAt(3)*4)+1]: false,
      listofAnswerQuestions[(rndNum.elementAt(3)*4)+2]: false,
      listofAnswerQuestions[(rndNum.elementAt(3)*4)+3]: false,
      listofAnswerQuestions[(rndNum.elementAt(3)*4)]: true,
    },
  ),
];
