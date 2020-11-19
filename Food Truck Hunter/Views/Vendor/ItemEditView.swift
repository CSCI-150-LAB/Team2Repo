//
//  ItemEditView.swift
//  Food Truck Hunter
//
//  Created by Oleksandr Babich on 11/18/20.
//

import SwiftUI

struct ItemEditView: View {
    @StateObject var viewModel = ItemViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {

            Form {
                Section(header: Text("Menu Item")) {
                    TextField("Title", text:$viewModel.item.title)
                    TextField("Price", value: $viewModel.item.price, formatter: NumberFormatter())
                    
                }
                
            }
            .navigationBarTitle("New Item", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { handleCancelTapped() }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: { handleDoneTapped() }, label: {
                    Text("Done")
                })
            )
            
            
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        viewModel.save()
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct ItemEditView_Previews: PreviewProvider {
    static var previews: some View {
        ItemEditView()
    }
}
