import SwiftUI

struct TruckClosingHourView: View {
    var truckClosingHour: String = ""
    
    func truckHourTimeFormat(_ closingHour: String) -> String {
        var truckClosingHour = closingHour
//        print("Closing hour is \(truckClosingHour)")

        let indexItem = truckClosingHour.index(truckClosingHour.startIndex, offsetBy: 2)
        truckClosingHour.insert(":", at: indexItem)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        
        let date = dateFormatter.date(from: truckClosingHour)
//        print("Time formatted is \(String(describing: date))")
        dateFormatter.dateFormat = "hh:mm a"
        let formattedTime = dateFormatter.string(from: date!)
        
//        print("formatted time is \(formattedTime)")
        
        return formattedTime
    }
    
    var body: some View {
        Text("Closes at \(truckHourTimeFormat(truckClosingHour))")
        Text("-")
        TruckHourStatusView(truckHourFromDatabase: truckClosingHour)
        Spacer()
    }
}
