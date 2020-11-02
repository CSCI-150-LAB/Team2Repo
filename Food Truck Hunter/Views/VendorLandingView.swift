//
//  VendorLandingView.swift
//  Food Truck Hunter
// this is the view that vendors will see to change their truck properties

import SwiftUI
func dummy() {

MapView()
print("inhere")
    // .frame(width: 100, height: 100)
}

struct VendorLandingPage: View {
    @State private var truckName: String = ""
    @State private var edit: String = "edit"

    var body: some View {
        ScrollView{
            Spacer()
                .frame(height: 35)
        VStack(alignment: .leading){
            HStack(){
                Spacer()
                Text(" 'TRUCK NAME' Settings")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                Spacer()
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
            DefaultButton(label: "Update", function: dummy)
                .frame(width: 350, height: 100)
                .padding(.top,-20)
                .padding(.bottom,0)
                .padding(.leading,15)
                //.ignoresSafeArea(.container)
            
            Text("Edit Hours Of Operation By Day:")
                .fontWeight(.bold)
                .padding(.leading,15)
                .padding(.top,-20)
                
        }
        VStack(alignment: .leading){
            HStack{
                Text("Monday:")
                    .padding(.leading, 25)
                //ENTER HOURS HERE
                Button( edit, action: dummy)
                    .foregroundColor(.red)
                Spacer()
            }
            HStack{
                Text("Tuesday:")
                    .padding(.leading, 25)
                //ENTER HOURS HERE
                Button( edit, action: dummy)
                    .foregroundColor(.red)
                Spacer()
            }
            HStack(){
                Text("Wednesday:")
                    .padding(.leading, 25)
                //ENTER HOURS HERE
                Button( edit, action: dummy)
                    .foregroundColor(.red)
                Spacer()
            }
            HStack{
                Text("Thursday:")
                    .padding(.leading, 25)
                //ENTER HOURS HERE
                Button( edit, action: dummy)
                    .foregroundColor(.red)
                Spacer()
            }
            HStack{
                Text("Friday:")
                    .padding(.leading, 25)
                //ENTER HOURS HERE
                Button( edit, action: dummy)
                    .foregroundColor(.red)
                Spacer()
            }
            HStack{
                Text("Saturday:")
                    .padding(.leading, 25)
                //ENTER HOURS HERE
                Button( edit, action: dummy)
                    .foregroundColor(.red)
                Spacer()
            }
            HStack{
                Text("Sunday:")
                    .padding(.leading, 25)
                //ENTER HOURS HERE
                Button( edit, action: dummy)
                    .foregroundColor(.red)
                Spacer()
                }
            }
        VStack(alignment: .leading){
            HStack{
            Text("Edit Location By Day:")
                .fontWeight(.bold)
                .padding(.top,2)
                .padding(.leading,15)
            Spacer()
            }
            VStack(alignment: .leading){
                HStack{
                    Text("Monday:")
                        .padding(.leading, 25)
                    // LOCATION INFO HERE
                    Button( edit, action: dummy)
                        .foregroundColor(.red)
                    Spacer()
                }
                HStack{
                    Text("Tuesday:")
                        .padding(.leading, 25)
                    // LOCATION INFO HERE
                    Button( edit, action: dummy)
                        .foregroundColor(.red)
                    Spacer()
                }
                HStack(){
                    Text("Wednesday:")
                        .padding(.leading, 25)
                    // LOCATION INFO HERE
                    Button( edit, action: dummy)
                        .foregroundColor(.red)
                    Spacer()
                }
                HStack{
                    Text("Thursday:")
                        .padding(.leading, 25)
                    // LOCATION INFO HERE
                    Button( edit, action: dummy)
                        .foregroundColor(.red)
                    Spacer()
                }
                HStack{
                    Text("Friday:")
                        .padding(.leading, 25)
                    // LOCATION INFO HERE
                    Button( edit, action: dummy)
                        .foregroundColor(.red)
                    Spacer()
                }
                HStack{
                    Text("Saturday:")
                        .padding(.leading, 25)
                    // LOCATION INFO HERE
                    Button( edit, action: dummy)
                        .foregroundColor(.red)
                    Spacer()
                }
                HStack{
                    Text("Sunday:")
                        .padding(.leading, 25)
                    // LOCATION INFO HERE
                    Button( edit, action: dummy)
                        .foregroundColor(.red)
                    Spacer()
                    }
                }
            
            Text("Edit Names Of Food Served:")
                .fontWeight(.bold)
                .padding(.top,2)
                .padding(.leading,15)
            
            // LIST OF FOODS HERE
            
            DefaultButton(label: "edit", function: dummy)
                .frame(width: 350, height: 100)
                .padding(.top,-20)
                .padding(.bottom,0)
                .padding(.leading,15)
            
            Text("Edit/Upload Menu Pictures:")
                .fontWeight(.bold)
                .padding(.leading,15)
                .padding(.top,2)
            
            //MENU PICTURES HERE
            
            DefaultButton(label: "edit", function: dummy)
                .frame(width: 350, height: 100)
                .padding(.top,-20)
                .padding(.bottom,0)
                .padding(.leading,15)
        
            
            Text("Edit/Upload Pictures Of Food:")
                .fontWeight(.bold)
                .padding(.leading,15)
                .padding(.top,2)
            
            //PICTURES OF FOOD
            
            DefaultButton(label: "edit", function: dummy)
                .frame(width: 350, height: 100)
                .padding(.top,-20)
                .padding(.bottom,0)
                .padding(.leading,15)
            
            Spacer()
        }
            

        // .navigationBarBackButtonHidden(true)
    }
        .background(Color(UIColor(red: 0.80, green: 0.87, blue: 0.89, alpha: 1.00)))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct VendorLandingView_Previews: PreviewProvider {
    static var previews: some View {
        VendorLandingPage()
    }
}
