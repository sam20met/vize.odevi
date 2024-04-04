//
//  ExamListView.swift
//  Vize ödevi
//
//  Created by samey on 4.04.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ExamListView: View {
    @State private var exams: [Exam] = []
    
    var body: some View {
        NavigationView {
            List(exams) { exam in
                NavigationLink(destination: ExamDetailView(exam: exam)) {
                    Text(exam.name)
                }
            }
            .navigationTitle("Sınavlar")
            .onAppear(perform: fetchExams)
        }
    }
    
    func fetchExams() {
        let db = Firestore.firestore()
        
        db.collection("exams").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No exams")
                return
            }
            
            self.exams = documents.compactMap { document in
                try? document.data(as: Exam.self)
            }
        }
    }
}
