import SwiftUI
import Firebase
import FirebaseFirestore

struct FavoriteListView: View {
    @EnvironmentObject var authState : AuthenticationState

    var body: some View {
        NavigationView {
            if let favorites = authState.session?.favorites as? [[String: Any]] {
                // Handle Optional Data Type
                Unwrap(favorites) { favorite in
                    if (favorite.count == 0) {
                        Text("No favorite trucks yet.")
                    } else {
                        List{
                            ForEach(0 ..< favorite.count) { index in
                                NavigationLink(destination: CustomerVendorView(isUsersFavorite: true, truckDocID: favorite[index]["truck_ref"] as! String)) {
                                    FavoriteRow(truckName: String(describing: favorite[index]["truck_name"] as! String).capitalized)
                                }
                            }
                        }.navigationBarTitle("My Favorites")
                    }
                }
            }
//            Text("Trucks count is \(authState.session?.favorites.count ?? 0)") // Debugging
        }
    }
}
