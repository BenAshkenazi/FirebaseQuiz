//
//  QuestionViewModel.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/23/22.
//

import SwiftUI
import Firebase

class QuestionViewModel: ObservableObject {
    @Published var questions = [Question]()
    
    func getQuestions(){
        let db = Firestore.firestore()
        
        db.collection("questions").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.questions = snapshot.documents.map{ docs in
                            return Question(id: docs.documentID,
                                            question: (docs["question"] as? String),
                                            optionA: docs["a"] as? String,
                                            optionB: docs["b"] as? String,
                                            optionC: docs["c"] as? String,
                                            answer: docs["answer"] as? String)
                        }
                        print(self.questions)
                    }
                    
                }
            }else{
                
            }
        }
        
    }
}

