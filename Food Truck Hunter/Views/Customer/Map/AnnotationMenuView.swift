//
//  AnnotationMenuView.swift
//  Food Truck Hunter
//
//  Created by Preston McCullough on 11/16/20.
//

import SwiftUI
import MapKit

func doNothing() {}
struct AnnotationMenuView: View {
    @Binding var pin: TruckPin?
    @Binding var mapMenu_shown: Bool
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
                            
                                }){
                            Text("exit")
                        }.padding(.trailing)
                    }.padding(.top)
                    Spacer()
                    DefaultButton(label: "Call",function: doNothing)
                    Spacer()
                    if let docRef = unwrapped.truckID {
                        NavigationLink(destination: CustomerVendorView(truckDocID: docRef)){
                            Text("Truck Page")
                        }
                    }
                }
            }
        }
    }
}
