import SwiftUI
import MapKit


struct LandingView: View {
//    @ObservableObject var user = UsersViewModel(userModel: UserModel(email: "", favorites: [], first_name: "", id: <#T##Int#>, last_name: <#T##String#>, phone_number: <#T##String#>, profile_img: <#T##String#>, review_count: <#T##Int#>, status: <#T##String#>, type: <#T##String#>))
    
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


