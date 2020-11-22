import SwiftUI

struct VendorMenuView: View {

    //var foodM = testData
    
    @ObservedObject private var viewModel = MenuViewModel()
    
    @State private var presentAddNewItemScreen = false
    
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
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { presentAddNewItemScreen.toggle() }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $presentAddNewItemScreen) {
                ItemEditView()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(UIColor(red: 0.80, green: 0.87, blue: 0.89, alpha: 1.00)))
            .onAppear() {
                self.viewModel.fetchData()
            }
        
            //.navigationBarHidden(true)
    

    }
}
}
    
//    struct VendorMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorMenuView()
//    }
//}
