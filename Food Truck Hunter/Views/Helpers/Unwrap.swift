import Foundation
import SwiftUI

struct Unwrap<FavoriteVendors, Content: View>: View {
    private let value : FavoriteVendors?
    private let contentProvider: (FavoriteVendors) -> Content
    
    init(_ value: FavoriteVendors?, @ViewBuilder content: @escaping (FavoriteVendors) -> Content) {
        self.value = value
        self.contentProvider = content
    }
    
    var body: some View {
        value.map(contentProvider)
    }
}
