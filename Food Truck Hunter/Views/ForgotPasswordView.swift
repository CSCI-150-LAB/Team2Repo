import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var buttonLabel : String = "Send Link"
    @State private var buttonColor : Color = Color.blue
    @State private var buttonDisable : Bool = false
    @State private var isLoading : Bool = false
    @State private var isRotating : Bool = false
    @State private var animateStrokeStart : Bool = false
    @State private var animateStrokeEnd : Bool = true
    
    @State var email : String = ""
    @State var invalidEmailHintLabel : String = ""
    
    var body: some View {
        ScrollView() {
            Section() {
                Text("Enter your email address so we can send you a link to reset your password.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 15)
                ZStack(alignment: .trailing) {
                    TextField("Email Address", text: self.$email, onEditingChanged: {_ in
                        if (self.email.isEmpty) {
                            self.invalidEmailHintLabel = ""
                        }
                        else {
                            if FormUtilities.validateEmail(self.email) {
                                self.invalidEmailHintLabel = ""
                            }
                        }
                    })
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.all)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(6)
                    if !self.email.isEmpty {
                        Button(action: {
                            self.email = ""
                            self.invalidEmailHintLabel = ""
                        }) {
                            Image(systemName: "multiply")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        }.padding(.trailing, 20)
                    }
                }
                
                Text(self.invalidEmailHintLabel)
                    .font(.system(size: 14))
                    .foregroundColor(Color.red)
                    .padding(.bottom, 2.0)
                    .animation(.easeInOut)
            }
            
            Section() {
                Button(action: {
                    if self.email.isEmpty {
                        self.invalidEmailHintLabel = FormUtilities.isEmptyErrorMsg(self.email, "email")
                    }
                    else {
                        self.invalidEmailHintLabel = ""
                        if FormUtilities.validateEmail(self.email) {
                            self.hideKeyboard()
                            buttonLabel = ""
                            buttonDisable.toggle()
                            isLoading.toggle()
                            Auth.auth().sendPasswordReset(withEmail: email) { error in
                                guard error == nil else {
                                    isLoading.toggle()
                                    buttonLabel = "Send link"
                                    buttonDisable.toggle()
                                    print("No account associated with \(self.email)\n")
                                    self.invalidEmailHintLabel = "No account associated with this email address."
                                    return
                                }

                                isLoading.toggle()
                                buttonColor = Color.green
                                buttonLabel = "Sent!"
                                print("Sent link to \(self.email).")
                                self.email = ""
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    buttonLabel = "Send link"
                                    buttonColor = Color.blue
                                    buttonDisable.toggle()
                                }
                            }
                        }
                        else {
                            self.invalidEmailHintLabel = FormUtilities.validateEmailErrorMsg(self.email)
                        }
                    }
                }) {
                    HStack {
                        Spacer()
                        ZStack {
                            if isLoading {
                                Circle()
                                    .trim(from: animateStrokeStart ? 1/3 : 1/9, to: animateStrokeEnd ? 2/5 : 1)
                                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .rotationEffect(Angle(degrees: isRotating ? 360 : 0))
                                    .opacity(isLoading ? 1 : 0)
                                    .onAppear() {
                                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                            isRotating.toggle()
                                        }
                                        
                                        withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                                            animateStrokeStart.toggle()
                                        }
                                        
                                        withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                                            animateStrokeEnd.toggle()
                                        }
                                    }
                            }

                            Text(buttonLabel)
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
                .disabled(buttonDisable)
                .accessibility(label: Text("Send password reset link"))
            }
        }
        .padding(.all)
        .navigationTitle("Forgot Your Password")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Login")
            }
        })
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(email: "")
    }
}
