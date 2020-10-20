import SwiftUI

struct AccountSettingView: View {
    @ObservedObject var user = UsersViewModel()
    
    var body: some View {
        VStack() {
            NavigationLink(destination: ContentView()) {
                DefaultButton(label: "Log out", function: user.logoutUser)
            }
        }
    }
}

