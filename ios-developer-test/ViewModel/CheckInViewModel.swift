import UIKit

class CheckInViewModel: NSObject {
    func checkInVehicle(licensePlate: String) -> EstatusCoreData {
        
        let coreDataManager = CoreDataManager()
        return coreDataManager.checkInVehicle(licensePlate: licensePlate)
    }
}
