import SwiftUI

struct FavoriteRow: View {
    var truckName: String
    var body: some View {
        HStack {
            Image("food-truck")
                .resizable()
                .frame(width: 50, height: 50)
            Text(truckName)
            Spacer()
        }
    }
}

//struct FavoriteRow<FavoriteVendors, Content: View>: View {
//    private let value : FavoriteVendors?
//    private let contentProvider: (FavoriteVendors) -> Content
//    
//    init(_ value: FavoriteVendors?, @ViewBuilder content: @escaping (FavoriteVendors) -> Content) {
//        self.value = value
//        self.contentProvider = content
//    }
//    
//    var body: some View {
//        value.map(contentProvider)
//    }
//}
