//
//  User.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/27/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Comparable{
    @DocumentID var idDoc: String?
    let id: UUID = UUID()
    var name: String?
    var score: Int?

    enum CodingKeys: String,CodingKey {
        case name
        case score = "0"
    }
    
    static func <(lhs: User, rhs: User) -> Bool {
            lhs.score! > rhs.score!
    }
}

