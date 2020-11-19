//
//  VendorLandingView.swift
//  Food Truck Hunter
// this is the view that vendors will see to change their truck properties

import SwiftUI

func dummy() {
    // do something here
    print("inhere")
    // .frame(width: 100, height: 100)

}

struct VendorSettingsView: View {
    @EnvironmentObject var authState : AuthenticationState
    @State private var truckName: String = ""
    @State private var edit: String = "edit"
    
    @State var successfullySignOut : Bool = false;
    
    func signOut() {
        self.successfullySignOut = authState.signOut()
    }

    @State private var  openStatus = false
    
    var body: some View {
        
        ScrollView{
            Spacer()
                .frame(height: 35)
        VStack(alignment: .leading){
            HStack(){
                Spacer()
                Text("'TRUCK NAME' Settings") // pull truck name here
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                Spacer()
            }
         //   vendorSwitch()
            HStack{
            Toggle(isOn: $openStatus){
                Spacer()
                Text("Open For Buisness : ")
                    .fontWeight(.bold)
                    .font(.system(size:20))
            }
            .padding(.trailing,120)
            }
            
            if (openStatus){
                //set status to open on firebase
            }
            else {
                // set status to closed on firebase
            }
            
            Spacer()
                .frame(height: 20)
            
            Text("Edit Your Truck name:")
                .fontWeight(.bold)
                .padding(.leading,10)
        
            TextField("  truck name here", text: $truckName)
                .autocapitalization(.none)
                .padding(.top,  10)
                .padding(.bottom, 10)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                .cornerRadius(15)
                .padding(.trailing,15)
                .padding(.leading, 15)
            DefaultButton(label: "Update Name", function: dummy)
                .frame(width: 350, height: 100)
                .padding(.top,-20)
                .padding(.bottom,0)
                .padding(.leading,15)
                //.ignoresSafeArea(.container)
            
            Text("Closing Time Today:")
                .fontWeight(.bold)
                .padding(.leading,15)
                .padding(.top,0)
            
            DefaultButton(label: "Update Time", function: dummy)
                .frame(width: 350, height: 100)
                .padding(.top,-20)
                .padding(.bottom,0)
                .padding(.leading,15)
                
        }
        VStack(alignment: .leading){
            HStack{
            Text("Current Location:")
                .fontWeight(.bold)
                .padding(.top,-5)
                .padding(.leading,15)
            Spacer()
            }
            
            DefaultButton(label: "Update Location", function: dummy)
                .frame(width: 350, height: 100)
                .padding(.top,-20)
                .padding(.bottom,0)
                .padding(.leading,15)
            
            
            //LOGOUT
            VStack{
                DefaultButton(label: "Logout", function: signOut, buttonColor: Color.white, bcolor: Color.red, lwidth: 5)
                .frame(width: 350, height: 100)
                .padding(.top,-20)
                .padding(.bottom,0)
                .padding(.leading,15)
                
                
                if successfullySignOut {
                    SignInView()
                }
                    
            }
            Spacer()
        }
            

        // .navigationBarBackButtonHidden(true)
    }
        .background(Color(UIColor(red: 0.80, green: 0.87, blue: 0.89, alpha: 1.00)))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct VendorSettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        VendorSettingsView()
    }
}
