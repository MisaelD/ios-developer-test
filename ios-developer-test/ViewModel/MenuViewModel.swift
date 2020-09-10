import UIKit

class MenuViewModel: NSObject {
    func startMonth(finished: (Bool) -> Void) {
        
        let coreDataManager = CoreDataManager()
        let deleteOficialVehicles = coreDataManager.deleteRecordsVehicles(type: "Oficial")
        let deleteResidentVehicles = coreDataManager.deleteRecordsVehicles(type: "Residente")
        finished(deleteOficialVehicles && deleteResidentVehicles)
    }
}
