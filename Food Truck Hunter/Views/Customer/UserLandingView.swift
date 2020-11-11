import SwiftUI
import MapKit
import FirebaseFirestore

struct LandingView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    
    func getLocations() {
        Firestore.firestore().collection("Trucks").getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    if let geopoints = document.get("location") {
                        let point = geopoints as! GeoPoint
                        print(point)
                        let lat = point.latitude
                        let lon = point.longitude
                        let cllPoint = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        let annotation = MKPointAnnotation()
                        if let truckName = document.get("name"){
                            let name = truckName as! String
                            annotation.title = name
                        }
                        else {
                            annotation.title = "Truck"
                        }
                        annotation.coordinate = cllPoint
                        locations.append(annotation)
                    }
                }
            }
        }
    }
    
    var body: some View {
        TabView {
            FavoriteListView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
            }
            ZStack{
                MapView(centerCoordinate: $centerCoordinate, annotations: locations).ignoresSafeArea()
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            getLocations()
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
            }
                .tabItem {
                    Image(systemName: "mappin.circle.fill")
                    Text("Nearby")
                }
            AccountSettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Account")
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}


