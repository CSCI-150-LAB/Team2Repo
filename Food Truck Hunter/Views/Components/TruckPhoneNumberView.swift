//
//  TruckPhoneNumberView.swift
//  Food Truck Hunter
//
//  Created by Sue Vang on 11/15/20.
//

import SwiftUI

struct TruckPhoneNumber: View {
    var phoneNumber: String = ""
    
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        var formattedPhoneNumber: String = phoneNumber
//        let firstParenthesisIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: 0)
//        formattedPhoneNumber.insert("(", at: firstParenthesisIndex)
//        let secondParenthesisIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: 4)
//        formattedPhoneNumber.insert(")", at: secondParenthesisIndex)
//        let hypenIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: 8)
//        formattedPhoneNumber.insert("-", at: hypenIndex)
        
        return formattedPhoneNumber
    }
    
    var body: some View {
        Text(formatPhoneNumber(self.phoneNumber))
    }
}

//struct TruckPhoneNumberView_Previews: PreviewProvider {
//    static var previews: some View {
//        TruckPhoneNumberView()
//    }
//}
