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
 //   var annotation: MKPointAnnotation
    
    var body: some View {
        VStack{
            HStack{
                Text("TRUCK NAME")
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
            DefaultButton(label: "Truck Page",function: doNothing)
        }
    }
}


