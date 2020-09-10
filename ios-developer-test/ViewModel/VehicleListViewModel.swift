import UIKit

class VehicleListViewModel: NSObject {

    func fechtVehicles(type: String) -> [Placa]? {
        let coreDataManager = CoreDataManager()
        return coreDataManager.vehicleList(type: type)
    }
}
