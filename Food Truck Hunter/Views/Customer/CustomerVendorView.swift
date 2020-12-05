//
//  CustomerVendorView.swift
//  Food Truck Hunter
// This is what customers will see when they click on a truck's pin on
// the map: this is also called a truck view
//
import Foundation
import SwiftUI
import MapKit

struct CustomerVendorView: View {

    @ObservedObject var viewModel: FavoriteListViewModel = FavoriteListViewModel()
    @State var isUsersFavorite = false
    var truckDocID: String
    
    func fetchTruck() {
//        self.viewModel.dispatchGroup.notify(queue: .main) {
        DispatchQueue.main.async {
            self.viewModel.getTruck(truckDocID: self.truckDocID)
            print("Data loaded!") 

        }
    }
    
    var body: some View {
        ScrollView() {
            if (self.viewModel.isDoneLoading) {
                VStack{
//                VStack(alignment:.center){
//    
//                    Text(self.viewModel.truck.truck_name.capitalized)
//                        .fontWeight(.bold)
//                        .font(.system(size: 25))
//                }
                
                Spacer()
                    .frame(height:10)
                
                    Text("\(self.viewModel.truck.truck_name )")
                    .font(.system(size: 30))
                    .bold()
                    
                Spacer()
                    .frame(height:15)
                    
                // CHECK HERE TO SEE IF USER HAS THIS TRUCK FAVORITED?
                Toggle(isOn: $isUsersFavorite){
                    Spacer()
                    Text("Add to favorites: ")
                        .font(.system(size:25))
                }
                .padding(.trailing,120)
                }
                VStack(alignment:.leading){
                    Group {
//                        HStack{
//                            TruckHourStatusView(truckHourFromDatabase: self.viewModel.truck.closing_hour)
//                        }
//                        Spacer()
//                            .frame(height:20)
                        
                        HStack{
                            Text("Location:")
                                .font(.system(size:25))
                            
                            Text("No Current Location")
                            
    //                        Text("2514 E Butler Ave, Fresno CA, 93721")
    //                            .font(.system(size: 20))
    //                            .foregroundColor(.blue)
                        }
                        
                        Spacer()
                            .frame(height:20)
                        
                        HStack{
                            TruckClosingHourView(truckClosingHour: self.viewModel.truck.closing_hour)
                                .font(.system(size:25))
                        }
                        
                        Spacer()
                            .frame(height:20)
                        
                        HStack{
                            Text("Phone:")
                                .font(.system(size:25))
                            TruckPhoneNumber(phoneNumber: self.viewModel.truck.phone_number)
                                .font(.system(size:25))
                        }
                        Spacer()
                            .frame(height:25)
                    }
                    NavigationLink(destination: CustomerVendormenuView()) {
                        Text("View Menu")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(Color.red)
                            .padding(.all,20)
                            .cornerRadius(10.0)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6.0)
                                    .stroke(Color.red, lineWidth: CGFloat(2)))
                            .padding(.leading,53)
                            .padding(.trailing,53)
                    }
                    
                }.padding(.horizontal)
                Spacer()
            }
            
        }
       // .navigationBarTitle(self.viewModel.isDoneLoading ? self.viewModel.truck.truck_name.capitalized : "Truck Name Here")
        .onAppear{
            self.fetchTruck()
        }
    }
}
