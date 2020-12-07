//
//  ItemEditView.swift
//  Food Truck Hunter
//
//  Created by Oleksandr Babich on 11/18/20.
//

import SwiftUI

struct ItemEditView: View {
    @StateObject var viewModel = ItemViewModel()
    @EnvironmentObject var authState : AuthenticationState
    @Environment(\.presentationMode) var presentationMode
    @State private var ftitle : String = ""
    @State private var fnum : String = "0"
    
    var body: some View {
        
        NavigationView {

            Form {
                Section(header: Text("Menu Item")) {
                    TextField("Title", text: $ftitle) // $viewModel.item.title)
                    TextField("Price", text : $fnum) //value: $fnum, formatter: NumberFormatter() ) // $viewModel.item.price)
                    
                }
                
            }
            .navigationBarTitle("New Item", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { handleCancelTapped() }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: { handleDoneTapped(foodname: ftitle, Foodprice: fnum, truckid: authState.session?.truck_id ?? 22) }, label: {
                    Text("Done")
                })
            )
            
            
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped(foodname: String, Foodprice: String, truckid: Int) {
        var fixed = Float(Foodprice) ?? -99
        viewModel.save(fname: foodname, Fprice: fixed, id: truckid)
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
