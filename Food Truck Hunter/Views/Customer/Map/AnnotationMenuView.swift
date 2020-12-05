//
//  AnnotationMenuView.swift
//  Food Truck Hunter
//
//  Created by Preston McCullough on 11/16/20.
//

import SwiftUI
import MapKit

func callsomeone(fav:FavoriteListViewModel,pin:TruckPin) {
   
    var number : String = ""
    
    DispatchQueue.main.async {
        fav.getTruck(truckDocID: pin.truckID)
    }
    
    number = fav.truck.phone_number
    
    var fixed : String = ""
    
    for letter in number
    {
        if (letter.isNumber)
        {
            fixed = fixed + String(letter)
        }
    }
    
    guard let caller = URL(string: "tel://" + "\(number)") else { return }
    UIApplication.shared.open(caller)
    
}
struct AnnotationMenuView: View {
    @Binding var pin: TruckPin?
    @Binding var mapMenu_shown: Bool
    @ObservedObject var truckModel: FavoriteListViewModel = FavoriteListViewModel()
    
    
    var body: some View {
        if let unwrapped = pin{
            if let truckName = unwrapped.title {
                
                VStack{
                    HStack{
                        Text(truckName)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .padding(.leading)
                        Spacer()
                        Button(action: {
                            mapMenu_shown = false
                        }){
                            Text("exit")
                        }.padding(.trailing)
                    }.padding(.top)
                    Spacer()
                    DefaultButton(label: "Call",function: {callsomeone(fav:truckModel, pin: unwrapped)},lwidth: 2)
                    
                        
                    if let docRef = unwrapped.truckID {
                    
                  //  DefaultButton(label: "Call",function: {callsomeone(number:"343")},lwidth: 2)

                        NavigationLink(destination: CustomerVendorView(truckDocID: docRef)){
                            Text("View Truck Page")
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
                    Spacer()
                    }
                }
            }
        }
        }
        
    }

