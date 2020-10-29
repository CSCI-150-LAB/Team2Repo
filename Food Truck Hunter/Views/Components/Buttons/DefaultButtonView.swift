import Foundation
import SwiftUI

struct DefaultButton: View {
    // Public variables
    let label : String
    let function : () -> Void
    var buttonColor : Color = Color.red

    // Used for animating loading circle
//    @State private var isCompleted : Bool = false
//    @State private var isLoading : Bool = false
//    @State private var isRotating : Bool = false
//    @State private var animateStrokeStart : Bool = false
//    @State private var animateStrokeEnd : Bool = true
    
  //  @State private var buttonColor : Color = Color.blue
//    @State private var isButtonDisabled : Bool = false
    
    var body: some View {
        Button(action: {
            self.hideKeyboard()
            self.function()
        }) {
            HStack() {
                Spacer()
                ZStack() {
//                    if (loadingAnimation && isLoading) {
//                        Circle()
//                            .trim(from: animateStrokeStart ? 1/3 : 1/9, to: animateStrokeEnd ? 2/5 : 1)
//                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
//                            .frame(width: 30, height: 30, alignment: .center)
//                            .rotationEffect(Angle(degrees: isRotating ? 360 : 0))
//                            .opacity(isLoading ? 1 : 0)
//                            .onAppear() {
//                                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
//                                    isRotating.toggle()
//                                }
//
//                                withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
//                                    animateStrokeStart.toggle()
//                                }
//
//                                withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
//                                    animateStrokeEnd.toggle()
//                                }
//                            }
//                    }
                    Text(label)
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(buttonColor)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(buttonColor, lineWidth: 1)
                        )
                }
                Spacer()
            }
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 44)
        .accessibility(label: Text("\(label) button"))
//        .disabled(isButtonDisabled)
//        .buttonStyle(DefaultButtonStyle(buttonColor: Color.blue)) // Currently not using this button style
    }
}


// Overrides Apple's button style
// Currently not using this but may later on
//public struct DefaultButtonStyle: ButtonStyle {
//    public let buttonColor : Color
//
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        return configuration.label
//
//    }
//}
//struct DefaultButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DefaultButton(lable: <#T##String#>, function: <#T##() -> Void#>, returnValue: <#T##Bool#>)
//    }
//}
