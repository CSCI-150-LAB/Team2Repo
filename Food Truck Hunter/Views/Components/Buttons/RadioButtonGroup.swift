import SwiftUI

struct RadioButtonGroup: View {

    let items : [String]

    @State var selectedLabel: String = ""

    let callback: (String) -> ()

    var body: some View {
        HStack {
            ForEach(0..<items.count) { index in
                RadioButton(self.items[index], callback: self.radioGroupCallback, selectedID: self.selectedLabel)
            }
        }
    }

    func radioGroupCallback(id: String) {
        selectedLabel = id
        callback(id)
    }
}
