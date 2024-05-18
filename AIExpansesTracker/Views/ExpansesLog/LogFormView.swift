//
//  LogFormView.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import SwiftUI

struct LogFormView: View {
    @State var viewModel: FormViewModel
    @Environment(\.dismiss) var dismiss

    #if !os(macOS)
    var title: String {
        ((viewModel.logToEdit == nil) ? "Ajouter" : "Modifier") + " une dépense"
    }

    var body: some View {
        NavigationStack {
            formView
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Terminé") {
                            self.onSaveTapped()
                        }
                        .disabled(viewModel.isSaveButtonDisabled)
                    }

                    ToolbarItem(placement: .cancellationAction) {
                        Button("Annuler") {
                            self.onCancelTapped()
                        }
                    }
                }
                .navigationBarTitle(title, displayMode: .inline)
        }
    }

    #else

    var body: some View {
        VStack {
            formView
                .padding()

            HStack {
                Button("Cancel") {
                    self.onCancelTapped()
                }

                Button("Save") {
                    self.onSaveTapped()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .disabled(viewModel.isSaveButtonDisabled)
            }
        }
        .frame(minWidth: 300)
    }

    #endif

    private var formView: some View {
        Form {
            TextField("Nom", text: $viewModel.name)
                .disableAutocorrection(true)

            TextField("Montant", value: $viewModel.amount, formatter: viewModel.numberFormatter)
            #if !os(macOS)
                .keyboardType(.numbersAndPunctuation)
            #endif

            Picker(selection: $viewModel.category) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue.capitalized)
                        .tag(category)
                }
            } label: {
                Text("Catégorie")
            }

            DatePicker(selection: $viewModel.date, displayedComponents: [.date, .hourAndMinute]) {
                Text("Date")
            }
        }
    }

    private func onCancelTapped() {
        dismiss()
    }

    private func onSaveTapped() {
        #if !os(macOS)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
        viewModel.save()
        dismiss()
    }
}
