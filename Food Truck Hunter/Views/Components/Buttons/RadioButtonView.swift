import Foundation
import SwiftUI

struct RadioButton: View {
    // Public variables
    let label : String
    let callback: (String)->()
    let selectedLabel : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let lwidth: Int

    init(
        _ label: String,
        callback: @escaping (String)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14,
        lwidth: Int = 1
        ) {
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedLabel = selectedID
        self.callback = callback
        self.lwidth = lwidth
    }
    
    @State private var selectedColor : Color = Color.blue
    @State private var defaultColor : Color = Color.gray
//    @State private var isButtonDisabled : Bool = false
    
    var body: some View {
        Button(action: {
            self.callback(self.label)
        }) {
            VStack() {
                HStack() {
                    Spacer()
                    Text(label)
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .foregroundColor(self.selectedLabel == self.label ? selectedColor : defaultColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(self.selectedLabel == self.label ? selectedColor : defaultColor, lineWidth: CGFloat(lwidth))
                                
                        )
                    Spacer()
                }
//                HorizontalLine(color: (self.selectedLabel == self.label ? selectedColor : defaultColor), height: 2.0)
            }.foregroundColor(self.color)
        }.foregroundColor(self.color)
//        .frame(minWidth: 0, maxWidth: 200)
        .accessibility(label: Text("Account type \(label) button"))
    }
}
