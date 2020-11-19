import SwiftUI

struct AccountSettingView: View {
    @EnvironmentObject var authState : AuthenticationState
    @State var successfullySignOut : Bool = false;
    
    func signOut() {
        self.successfullySignOut = authState.signOut()
    }

    
    var body: some View {
        NavigationView{
        VStack(alignment:.center) {
            if authState.session != nil {
              //  Text(authState.session?.displayName ?? "empty")
                //Text(authState.session?.uid ?? "empty")
                if (authState.session?.profile_img == ""){
                    Image("blank-profile-pic")
                }
                else{
                Image(authState.session?.profile_img ?? "blank-profile-pic" )
                }
                HStack{
                    Spacer()
                        .frame(width:5)
                    Text("Name:")
                        .bold()
                    Text("\(authState.session?.first_name?.capitalized ?? "no first name" ) \(authState.session?.last_name?.capitalized ?? "no last name")")
                    Spacer()
                }
                HStack{
                    Spacer()
                        .frame(width:5)
                    Text("Email:")
                        .bold()
                    Text("\(authState.session?.email ?? "no email") ")
                    Spacer()
                }
                HStack(){
                    Spacer()
                        .frame(width:5)
                    Text("Phone Number:")
                        .bold()
                    if (authState.session?.phone_number == ""){
                        Text("no number saved")
                    }
                    else{
                    Text("\(authState.session?.phone_number ?? "no number") ")
                    }
                    Spacer()
                }
            }
            VStack{
                HStack{
                NavigationLink(destination: CustomerEditProfileView() )
                {
                                        
                    Text("Edit Profile Info")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(Color.black)
                        .padding(.all,20)
                        .cornerRadius(10.0)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color.black, lineWidth: CGFloat(2)))
                        .padding(.leading,53)
                        .padding(.trailing,53)
                
            }
                }
            
            Spacer()
                .frame(height:20)
            DefaultButton(label: "Logout", function: signOut, lwidth: 2)
            
            if successfullySignOut{
                SignInView()
            }
        
      }
    }
   }
}
}
