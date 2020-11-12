import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let vertHeight: Int = 80
    
    var body: some View {
        VStack(alignment: .leading) {
            Section() {
                Text("I would like to sign up as:")
                    .font(.system(size: 16))
                    .padding(.top, 25)
                    .padding(.bottom, 8)
                VStack(alignment: .leading, spacing: 20) {
                    // Customer Sign Up View
                    NavigationLink(destination: CustomerSignUpView()) {
                        Spacer()
                        Text("Customer")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(Color.red)
                            .padding(.vertical, 40)
                            .cornerRadius(10.0)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6.0)
                                    .stroke(Color.red, lineWidth: CGFloat(1))
                                    
                            )
                        Spacer()
                    }
                    // Vendor Sign Up View
                    NavigationLink(destination: VendorSignUpView()) {
                        Spacer()
                        Text("Vendor")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(Color.red)
                            .padding(.vertical, 40)
                            .cornerRadius(10.0)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6.0)
                                    .stroke(Color.red, lineWidth: CGFloat(1))
                                    
                            )
                        Spacer()
                    }
                    Spacer()
                }
            }.padding(.horizontal)
        }
        .navigationTitle("Account Type")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Sign In")
            }
        })
    }
}
