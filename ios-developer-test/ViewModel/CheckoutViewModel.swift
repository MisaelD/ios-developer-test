import UIKit

class CheckoutViewModel: NSObject {
    func checkOutVehicle(licensePlate: String) -> (EstatusCoreData, Estancia?) {
        
        let coreDataManager = CoreDataManager()
        let result = coreDataManager.checkOutVehicle(licensePlate: licensePlate)
        return (result.0, result.1)
    }
}
