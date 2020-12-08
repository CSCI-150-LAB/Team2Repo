//
//  VendorLandingView.swift
//  Food Truck Hunter
// this is the view that vendors will see to change their truck properties

import SwiftUI
import FirebaseFirestore

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

    @ObservedObject var viewModel = VendorSettingsViewModel()
    
    func fetchTruck(){
        if let ref = authState.session?.truck_ref
        {
            self.viewModel.getTruck(truckDocID: ref)
        }
    }
   
    
    func updateTruckName(){
        if(truckName != ""){ // if textfield isn't empty
            if let uid = authState.session?.uid {
                self.viewModel.updateTruckName(truckName: truckName, uid: uid)
                authState.session?.truck_name = truckName
                truckName = ""
                }
            }
        }
    
    
    
    func updateLocation(){
        self.viewModel.updateLocation()
    }
    
    var body: some View {
        
        ScrollView{
            Spacer()
            .frame(height: 35)
            VStack(alignment: .leading){
                HStack(){
                    Spacer()
                    Text("\(self.viewModel.truck.truck_name) Settings") // pull truck name here
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    Spacer()
                }

               
                Toggle(isOn: $viewModel.toggleValue){
                    Spacer()
                    Text("Open For Buisness: ")
                        .fontWeight(.bold)
                        .font(.system(size:20))
                        
                }
                    
                
        
                
        
                Spacer()
                    .frame(height: 20)
                
                HStack{
                    Text("Closing Time Today:")
                        .fontWeight(.bold)
                        .font(.system(size:20))
                        .padding(.leading,15)
                        .padding(.top,0)
                        .padding(.trailing,15)
                        
                    DatePicker("", selection: $viewModel.closingTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    
                    
                }
                
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
                DefaultButton(label: "Update Name", function: updateTruckName)
                    .frame(width: 350, height: 100)
                    .padding(.top,-20)
                    .padding(.bottom,0)
                    .padding(.leading,15)
                    //.ignoresSafeArea(.container)
                
            
            }
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    Text("Current Location:")
                        .fontWeight(.bold)
                        .padding(.top,-5)
                        .padding(.leading,15)
                    Spacer()
                }
        
                DefaultButton(label: "Update Location", function: updateLocation)
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
        .onAppear(perform: self.fetchTruck)
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

