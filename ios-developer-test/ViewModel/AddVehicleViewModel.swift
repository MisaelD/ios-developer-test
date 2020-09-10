import UIKit

class AddVehicleViewModel: NSObject {
    func saveVehicle(license: String, tipo: String, finished: (Bool) -> Void) {
        
        let coreDataManager = CoreDataManager()
        coreDataManager.saveVehicle(license: license, tipo: tipo, finished: { success in
            finished(success)
        })
    }
}
