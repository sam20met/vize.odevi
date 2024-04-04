//
//  ContentView.swift
//  Vize ödevi
//
//  Created by samey on 4.04.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct CreateExamView: View {
    @State private var examName: String = ""
    @State private var examDuration: String = ""
    @State private var questions: [Question] = []
    @State private var questionText: String = ""
    @State private var options: [String] = Array(repeating: "", count: 4)
    @State private var correctOptionIndex: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sınav Bilgileri")) {
                    TextField("Sınav Adı", text: $examName)
                    TextField("Sınav Süresi (dk)", text: $examDuration)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Soru Ekle")) {
                    TextField("Soru Metni", text: $questionText)
                    ForEach(0..<4, id: \.self) { index in
                        TextField("Seçenek \(index + 1)", text: $options[index])
                    }
                    Picker("Doğru Cevap", selection: $correctOptionIndex) {
                        ForEach(0..<4, id: \.self) { index in
                            Text("Seçenek \(index + 1)").tag(index)
                        }
                    }
                    Button(action: addQuestion) {
                        Text("Soruyu Ekle")
                    }
                }
                
                Section {
                    Button(action: saveExam) {
                        Text("Sınavı Kaydet")
                    }
                }
            }
            .navigationTitle("Sınav Oluştur")
        }
    }
    
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
}
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ExamListView()) {
                    Text("Sınavları Görüntüle")
                }
                
                NavigationLink(destination: CreateExamView()) {
                    Text("Sınav Oluştur")
                }
            }
            .navigationTitle("Ana Sayfa")
        }
    }
}
