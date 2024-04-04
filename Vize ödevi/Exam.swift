//
//  Exam.swift
//  Vize ödevi
//
//  Created by samey on 4.04.2024.
//

import FirebaseFirestoreSwift

struct Exam: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var duration: Int
    var questions: [Question]
}

struct Question: Codable {
    var text: String
    var options: [String]
    var correctOption: Int
}

