import SwiftUI

class profileInfo{
    var first = "nothing"
}

struct AccountSettingView: View {
    @EnvironmentObject var authState : AuthenticationState
    @State var successfullySignOut : Bool = false;
    @State var first = "initial"
    @State var last = "initial"
    @State var num = "initial"
    
    func signOut() {
        self.successfullySignOut = authState.signOut()
    }
    
    func refresh(){
        first = authState.session?.first_name ?? "no first name saved"
        last = authState.session?.last_name ?? "no last name saved"
        num = authState.session?.phone_number ?? "no number saved"
    }
    
    var body: some View {
        NavigationView{
        VStack(alignment:.center) {
            if authState.session != nil {
                             
                
                Button(action: refresh){
                    HStack(spacing:5){
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.red)
                        Text("refresh")
                            .foregroundColor(.red)
                    }
                }
                
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
                    
                    if(first == "initial" ){ // if values are still the same from inital query
                    Text("\(authState.session?.first_name?.capitalized ?? "no first name" ) \(authState.session?.last_name?.capitalized ?? "no last name")") // show from database
                    }else{
                        Text("\(first.capitalized) \(last.capitalized)") // show from the state variables (needs to hit refresh button)
                    }
                    
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
                    
                    if(num == "initial" ){
                        Text("\(authState.session?.phone_number ?? "no number saved") ")
                    }else{
                        Text("\(num)")
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
