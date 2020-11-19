import SwiftUI

struct CustomerEditProfileView: View {
    @State private var fName: String = ""
    @State private var lName: String = ""
    @State private var Phonenum: String = ""
    
    func updateLastName()
    {
        if(lName != ""){
        print("u l n")
        }
    }
    
    func updateFirstName()
    {
        if(fName != ""){
        print("u f n")
        }

    }
    
    func updatePhone()
    {
        if(Phonenum != ""){
        print("u num")
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
                DefaultButton(label: "Update Last Name", function: updateLastName)
                    .frame(width: 350, height: 100)
                    .padding(.top,-5)
                    .padding(.bottom,0)
                    .padding(.leading,15)
                
                Text("Edit Your Phone Number:")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.leading,10)
                VStack{
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
