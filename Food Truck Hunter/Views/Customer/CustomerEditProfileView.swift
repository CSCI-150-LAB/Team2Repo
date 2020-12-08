import SwiftUI
import FirebaseFirestore

struct CustomerEditProfileView: View {
    
    @State private var fName: String = ""
    @State private var lName: String = ""
    @State private var Phonenum: String = ""
    
    @EnvironmentObject var authState : AuthenticationState
    
    let db = Firestore.firestore()
  
    func updateLastName()
    {
        if(lName != ""){ // if textfield isn't empty
            if let uid = authState.session?.uid{
                db.collection("Users").document(uid).setData(["last_name": lName],merge:true)
                authState.session?.last_name = lName
            }
        }
    }
    
    func updateFirstName()
    {
        if(fName != ""){// if textfield isn't empty
            if let uid = authState.session?.uid{
                db.collection("Users").document(uid).setData(["first_name": fName],merge:true)
                authState.session?.first_name = fName
            }
        }
    }
    
    func updatePhone()
    {
        if(Phonenum != ""){ // if textfield isn't empty
            if let uid = authState.session?.uid{
                db.collection("Users").document(uid).setData(["phone_number": Phonenum],merge:true)
                authState.session?.phone_number = Phonenum
            }
        }
    }
    
    func updatePic()
    {
        print("updating profile pic")
    }
    
    
    var body: some View {
        
        ScrollView()
        {
            VStack
            {
                Spacer()
                    .frame(height:90)
                
                DefaultButton(label: "Update Profile Pic", function: updatePic )
                    .frame(width: 350, height: 100)
                    .padding(.top,-5)
                    .padding(.bottom,0)
                    .padding(.leading,15)
                

                Text("Edit Your First Name:")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.leading,10)
            
                TextField("  First name", text: $fName)
                    .autocapitalization(.none)
                    .padding(.top,  10)
                    .padding(.bottom, 10)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(15)
                    .padding(.trailing,15)
                    .padding(.leading, 15)
                DefaultButton(label: "Update First Name", function: updateFirstName)
                    .frame(width: 350, height: 100)
                    .padding(.top,-5)
                    .padding(.bottom,0)
                    .padding(.leading,15)
                
                Text("Edit Your Last Name:")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.leading,10)
            
                TextField("  Last Name", text: $lName)
                    .autocapitalization(.none)
                    .padding(.top,  10)
                    .padding(.bottom, 10)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(15)
                    .padding(.trailing,15)
                    .padding(.leading, 15)
                VStack{
                DefaultButton(label: "Update Last Name", function: updateLastName)
                    .frame(width: 350, height: 100)
                    .padding(.top,-5)
                    .padding(.bottom,0)
                    .padding(.leading,15)
                
                Text("Edit Your Phone Number:")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.leading,10)
        
                TextField("  Phone Number", text: $Phonenum)
                    .autocapitalization(.none)
                    .padding(.top,  10)
                    .padding(.bottom, 10)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(15)
                    .padding(.trailing,15)
                    .padding(.leading, 15)
                
                    DefaultButton(label: "Update Phone Number", function: updatePhone )
                        .frame(width: 350, height: 100)
                        .padding(.top,-5)
                        .padding(.bottom,0)
                        .padding(.leading,15)
                }
                
            }
            
    
        }
        .accentColor(.red)
        .background(Color(UIColor(red: 0.80, green: 0.87, blue: 0.89, alpha: 1.00)))
        .ignoresSafeArea(edges: .top)
        
    }
}

struct CustomerEditProfileView_Previews: PreviewProvider
{
    static var previews: some View {
       CustomerEditProfileView()
    }
}
