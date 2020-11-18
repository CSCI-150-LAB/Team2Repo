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
              //  Text(authState.session?.displayName ?? "empty")
                //Text(authState.session?.uid ?? "empty")
                Text("Name: \(authState.session?.first_name ?? "no first name" ) \(authState.session?.last_name ?? "no last name")")
                
                Text("Email: \(authState.session?.email ?? "empty") ")
            }
            
            DefaultButton(label: "Logout", function: signOut)
            
            if successfullySignOut{
                SignInView()
            }
        }
    }
}
