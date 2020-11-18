import SwiftUI

struct MainView: View {
    @EnvironmentObject var authState: AuthenticationState

    func getUser () {
        authState.listen()
    }
    
    var body: some View {
      Group {
        if (authState.session != nil) {
            AnyView(VendorLandingView())
        } else {
          // AnyView(VendorLandingView()) // used to see/modify vendor view
           AnyView(SignInView()) // use this for normal functionality
          //  AnyView(CustomerVendorView()) // use to test truck page
        }
      }.onAppear(perform: getUser)  }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
