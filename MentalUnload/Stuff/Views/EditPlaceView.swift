//
//  EditPlaceView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//



import SwiftUI

struct EditPlaceView: View {
    var place: Place
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State var nameOfPlace = ""
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.lightGrey)
                Form {
                    Text("Change name:").font(.title2).foregroundStyle(.gray)
                    TextField("name of place", text: $nameOfPlace).font(.title).textFieldStyle(.roundedBorder).padding()
                    Text("Choose major category places like house, shed, attic or cellar.\nThen specify something like a cupboard, shelf or box in the detailed description field provided in the item's menu.")
                        .foregroundStyle(.gray)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading, content: {
                        Button("Back") {
                            dismiss()
                        }
                    })
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button("Save") {
                            place.name = nameOfPlace
                            dismiss()
                        }
                    })
                }
                .task {
                    nameOfPlace = place.name
                }
            }
        }
    }
}


