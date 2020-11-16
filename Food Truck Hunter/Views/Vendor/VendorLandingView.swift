import SwiftUI


struct VendorLandingView: View {
    var body: some View {
        TabView {
            VendorMenuView()
                .ignoresSafeArea(.all)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("My Menu")
            }
            VendorSettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Truck Settings")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct VendorLandingView_Previews: PreviewProvider {
    static var previews: some View {
        VendorLandingView()
    }
}
