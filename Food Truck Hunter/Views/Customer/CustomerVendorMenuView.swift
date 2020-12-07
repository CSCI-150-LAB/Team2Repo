import SwiftUI

struct CustomerVendormenuView: View {

    //var foodM = testData
    
    @ObservedObject private var viewModel = MenuViewModel()
    
    @State private var presentAddNewItemScreen = false
    @State var truckkID : Int = 0
    
    var body: some View {
        
        NavigationView {
            List(viewModel.items) { food in
                let formattedPrice = String(format: "%.2f", food.price)
                VStack(alignment: .leading) {
                    
                    Text(food.title)
                        .font(.headline)
                    Text("$ \(formattedPrice)")
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("Food Menu")
            .sheet(isPresented: $presentAddNewItemScreen) {
                ItemEditView()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(UIColor(red: 0.80, green: 0.87, blue: 0.89, alpha: 1.00)))
            .onAppear() {
                self.viewModel.fetchData(truckref:truckkID )
            }
        
            //.navigationBarHidden(true)
    }
}
}
