//
//  TempLandingView.swift
//  Food Truck Hunter
//
//  Created by Preston McCullough on 10/2/20.
//

import SwiftUI
import MapKit


struct LandingView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 36.8134,
                longitude: -119.7461
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 1,
                longitudeDelta: 1
            )
        )
    
    var body: some View {
        TabView {
            Text("Favourites Screen")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
            }
            Map(coordinateRegion: $region)
                .tabItem {
                    Image(systemName: "mappin.circle.fill")
                    Text("Nearby")
            }
            Text("Account Settings Screen")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Account")
            }
            
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}


