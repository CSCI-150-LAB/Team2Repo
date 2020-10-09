import SwiftUI

struct DefaultButton: View {
    // Public variables
    let label: String
    let function: () -> Void
    var returnValue: Bool
    
    // Used for animating loading circle
    @State private var isLoading : Bool = false
    @State private var isRotating : Bool = false
    @State private var animateStrokeStart : Bool = false
    @State private var animateStrokeEnd : Bool = true
    
    @State private var buttonColor : Color = Color.blue
    @State private var buttonDisable : Bool = false;
    
    var body: some View {
        Button(action: {
            self.function()
        }) {
            HStack() {
                Spacer()
                Text(label)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(buttonColor)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 6.0)
                            .stroke(buttonColor, lineWidth: 1)
                    )
                Spacer()
            }
        }
        .padding(.bottom, 5)
        .padding(.horizontal)
        .accessibility(label: Text("Create account button"))
        .disabled(buttonDisable)
//        .buttonStyle(DefaultButtonStyle(buttonColor: Color.blue)) // Currently not using this button style
    }
}


// Overrides Apple's button style
// Currently not using this but may later on
public struct DefaultButtonStyle: ButtonStyle {
    public let buttonColor : Color
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label

    }
}
//struct DefaultButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DefaultButton(lable: <#T##String#>, function: <#T##() -> Void#>, returnValue: <#T##Bool#>)
//    }
//}
