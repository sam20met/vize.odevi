//
//  CreateExamView.swift
//  Vize ödevi
//
//  Created by samey on 4.04.2024.
//

import SwiftUI

struct CreateExamView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CreateExamView()
    
    func addQuestion() {
        let newQuestion = Question(text: questionText, options: options, correctOption: correctOptionIndex)
        questions.append(newQuestion)
        questionText = ""
        options = Array(repeating: "", count: 4)
        correctOptionIndex = 0
    }

    func saveExam() {
        let db = Firestore.firestore()
        
        let newExam = Exam(name: examName, duration: Int(examDuration) ?? 0, questions: questions)
        
        do {
            _ = try db.collection("exams").addDocument(from: newExam)
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving exam: \(error)")
        }
    }
