import SwiftUI

struct MainView: View {
    @EnvironmentObject var authState: AuthenticationState

    func getUser () {
        authState.listen()
    }
    
    var body: some View {
      Group {
        if (authState.session != nil) {
            switch authState.session?.type {
            case "vendor":
                AnyView(VendorLandingPage()) // used to see/modify vendor view
            case "customer":
                AnyView(LandingView())
            default:
                SignInView()
            }
        } else {
           AnyView(SignInView()) // use this for normal functionality
        }
      }.onAppear(perform: getUser)  }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
