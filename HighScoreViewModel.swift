//
//  HighScoreViewModel.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/27/22.
//

import SwiftUI
import Firebase

class HighScoreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var uniqueIDDoc = ""
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func logMostRecentUID() -> String{
        uniqueIDDoc = randomString(length: 20)
        return uniqueIDDoc
    }
    
    
    func getUsers(){
        let db = Firestore.firestore()

        db.collection("highscores").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.users = snapshot.documents.map{ docs in
                            return User(idDoc: docs.documentID,
                                        name: (docs["name"] as? String),
                                        score: docs["score"] as? Int)
                        }
                        print(self.users)
                    }
                    
                }
            }else{
                
            }
        }
        users.sort()
    }
    
   
    
    func putInUser(userName: String, userScore: Int){
        let db = Firestore.firestore()
        //var newUser = User(id: randomString(length: 20), name: userName, score: userScore)
        
        db.collection("highscores").document(logMostRecentUID()).setData([
            "name": userName,
            "score": userScore
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        getUsers()
        
    }
    
   
    
    
}
