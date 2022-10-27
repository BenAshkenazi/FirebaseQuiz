//
//  HighScoreView.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/27/22.
//

import SwiftUI

struct HighScoreView: View {
    var points: Int
    @StateObject var data = HighScoreViewModel()

    
    var body: some View {
        VStack{
            List(data.users) { user in
                //Text(user.score)
                Text(user.name!)
            }

        }.onAppear{
            print("highscores up")
        }
    }
    
}

