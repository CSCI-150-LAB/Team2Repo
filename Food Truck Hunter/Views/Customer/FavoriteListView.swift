import SwiftUI
import Firebase
import FirebaseFirestore

struct FavoriteListView: View {
//    @State var favoriteList : FavoriteVendors\
    @EnvironmentObject var authState : AuthenticationState
    var body: some View {
        NavigationView {
            if authState.session != nil {
                List{
//                    Text("Trucks count is \(authState.session?.favorites.count ?? 0)") // Debugging
                    if let favorites = authState.session?.favorites as? [[String: Any]]{
                        // Handle Optional
                        Unwrap(favorites) { favorite in
                            ForEach(0 ..< favorite.count) { index in
                                NavigationLink(destination: CustomerVendorView()) {  // Pass in vendor's details to Customer's Vendor View
                                    HStack {
                                        Image("food-truck")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        Text(String(describing: favorite[index]["truck_name"] as! String).capitalized)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("My Favorites")
            }
        }
        //DefaultButton(label: "Tap me", function: getUserData)
    }
}
