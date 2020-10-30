import SwiftUI

struct AccountSettingView: View {
    @EnvironmentObject var authState : AuthenticationState
    @State var successfullySignOut : Bool = false;
    
    func signOut() {
        self.successfullySignOut = authState.signOut()
    }
    
    var body: some View {
        VStack() {
            if authState.session != nil {
                Text(authState.session?.displayName ?? "empty")
                Text(authState.session?.uid ?? "empty")
                Text(authState.session?.email ?? "empty")
            }
            DefaultButton(label: "Logout", function: signOut)
            if successfullySignOut {
                SignInView()
            }
        }
    }
}
