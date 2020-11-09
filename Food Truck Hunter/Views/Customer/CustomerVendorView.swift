//
//  CustomerVendorView.swift
//  Food Truck Hunter
// This is what customers will see when they click on a truck's pin on
// the map: this is also called a truck view
//

import SwiftUI

struct CustomerVendorView: View {
    @State private var  Favorited = false
    var body: some View {
        
        VStack(alignment:.center){
            Text("TRUCK NAME")
                .fontWeight(.bold)
                .font(.system(size: 25))
        }
        Spacer()
            .frame(height:20)
        
        HStack{
        // CHECK HERE TO SEE IF USER HAS THIS TRUCK FAVORITED?
        Toggle(isOn: $Favorited){
            Spacer()
            Text("Add to favorites: ")
                .fontWeight(.bold)
                .font(.system(size:20))
        }
        .padding(.trailing,120)
        }
        
        if (Favorited){
            // ADD TRUCK TO USER'S FAVORITES
        }
        else {
            // REMOVE TRUCK FROM USER'S FAVORITES
        }
        
        VStack(alignment:.leading){
            HStack{
                Text("Currently:")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Text("Open")
                    .font(.system(size: 20))
                    .foregroundColor(.green)
            }
            Spacer()
                .frame(height:20)

            HStack{
                Text("Closing time:")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                Text("11:30pm")
                    .font(.system(size: 20))
            }
            
            Spacer()
                .frame(height:20)
            
            HStack{
                Text("Location:")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                Text("2514 E Butler Ave, Fresno CA, 93721")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
            }
            
            Spacer()
                .frame(height:20)
            
            HStack{
                Text("Phone Number:")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                Text ("559-704-2746")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
            }
            Spacer()
                .frame(height:25)
        }
        VStack(alignment:.center){
            Text("Menu:")
                .fontWeight(.bold)
                .font(.system(size: 25))
        }
        ScrollView(){
                
            // ADD TRUCK MENU ITEM ROWS HERE
            
        }
        Spacer()
    }
}

struct CustomerVendorView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerVendorView()
    }
}
