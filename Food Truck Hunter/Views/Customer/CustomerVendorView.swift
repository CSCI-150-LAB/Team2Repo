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
//                VStack(alignment:.center){
//                    Text(self.viewModel.truck.truck_name.capitalized)
//                        .fontWeight(.bold)
//                        .font(.system(size: 25))
//                }
                Spacer()
                    .frame(height:20)
                
                // CHECK HERE TO SEE IF USER HAS THIS TRUCK FAVORITED?
                Toggle(isOn: $isUsersFavorite){
                    Spacer()
                    Text("Add to favorites: ")
                        .fontWeight(.bold)
                        .font(.system(size:20))
                }
                .padding(.trailing,120)
                
                VStack(alignment:.leading){
                    Group {
//                        HStack{
//                            TruckHourStatusView(truckHourFromDatabase: self.viewModel.truck.closing_hour)
//                        }
//                        Spacer()
//                            .frame(height:20)
                        
                        HStack{
                            Text("Location:")
    //                        Text("2514 E Butler Ave, Fresno CA, 93721")
    //                            .font(.system(size: 20))
    //                            .foregroundColor(.blue)
                        }
                        
                        Spacer()
                            .frame(height:20)
                        
                        HStack{
                            TruckClosingHourView(truckClosingHour: self.viewModel.truck.closing_hour)
                        }
                        
                        Spacer()
                            .frame(height:20)
                        
                        HStack{
                            TruckPhoneNumber(phoneNumber: self.viewModel.truck.phone_number)
                        }
                        Spacer()
                            .frame(height:25)
                    }
                    NavigationLink(destination: CustomerVendorMenu()) {
                        Text("View menu")
                    }
                    
                }.padding(.horizontal)
                Spacer()
            }
        }
        .navigationBarTitle(self.viewModel.isDoneLoading ? self.viewModel.truck.truck_name.capitalized : "Truck Name Here")
        .onAppear{
            self.fetchTruck()
        }
    }
}
