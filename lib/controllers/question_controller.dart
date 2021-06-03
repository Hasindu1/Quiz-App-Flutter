import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_app/models/question.dart';

class QuestionController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // get all quesions
  getAllQuestions(){
    return _db.collection('test').snapshots();
  }

//add question , options and correct answers
  addQuestion(Question questionObj) async{

    try{

     _db.runTransaction(
        (Transaction transaction) async{
            await _db.collection('test').doc().set(questionObj.toMap());
        }
      );
    }catch(e){
        print(e.toString());
    }
  }

//update questions, options and correct answers.
  updateQuestion(Question questionObj,String question,List<String> optionsList,List<bool> answerList){
    try{

      _db.runTransaction((transaction) async {
        await transaction.update(questionObj.id, {'question': question,'options': optionsList,'answerList': answerList});
      });
    }catch(e){
        print(e.toString());
    }
  }


//delete question
  deleteQuestion(Question question){
      _db.runTransaction(
        (Transaction transaction) async{
            await transaction.delete(question.id);

        });
  }  

}