import SwiftUI

struct TruckHourStatusView: View {
    var truckHourFromDatabase: String = ""
    
    func checkTruckHour(_ hourFromData: String) -> Bool {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        
        let currentTime = (dateFormatter.string(from: date as Date))
        
        let compareResult = currentTime <= hourFromData
//        print("current hour: \(currentTime) truck hour: \(hourFromData)")
        
        // Returns true if truck is open, otherwise false for is closed
        return compareResult
    }
    
    var body: some View {
        if (checkTruckHour(truckHourFromDatabase)) {
            Text("Open")
                .fontWeight(.bold)
                .foregroundColor(Color.green)
        } else {
            Text("Closed")
                .fontWeight(.bold)
                .foregroundColor(Color.red)
        }
    }
}

//struct TruckHourStatusView_Previews: PreviewProvider {
//    static var previews: some View {
//        TruckHourStatusView()
//    }
//}
