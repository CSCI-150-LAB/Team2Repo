import SwiftUI


struct VendorMenuView: View {
    var body: some View {
        ScrollView
        {
            VStack(alignment: .center){
            Text("menu goes here")
                .padding(.top,35)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color(UIColor(red: 0.80, green: 0.87, blue: 0.89, alpha: 1.00)))
        .navigationBarHidden(true)
    }
    
}

struct VendorMenuView_Previews: PreviewProvider {
    static var previews: some View {
        VendorMenuView()
    }
}
