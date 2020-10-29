import Foundation
import SwiftUI


func test() {
    print("do something.")
}

struct RadioButton: View {
    // Public variables
    let label : String
    let callback: (String)->()
    let selectedLabel : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init(
        _ label: String,
        callback: @escaping (String)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14
        ) {
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedLabel = selectedID
        self.callback = callback
    }
    
//    Used for animating loading circle
//    @State private var isCompleted : Bool = false
//    @State private var isLoading : Bool = false
//    @State private var isRotating : Bool = false
//    @State private var animateStrokeStart : Bool = false
//    @State private var animateStrokeEnd : Bool = true
    
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
                        .padding(.horizontal)
                        .padding(.vertical, 3)
                        .foregroundColor(self.selectedLabel == self.label ? selectedColor : defaultColor)
                    Spacer()
                }
                HorizontalLine(color: (self.selectedLabel == self.label ? selectedColor : defaultColor), height: 2.0)
            }.foregroundColor(self.color)
        }.foregroundColor(self.color)
//        .frame(minWidth: 0, maxWidth: 200)
        .accessibility(label: Text("\(label) button"))
    }
}

//struct RadioButton_Previews: PreviewProvider {
//    static var previews: some View {
//        RadioButton("User")
//    }
//}
