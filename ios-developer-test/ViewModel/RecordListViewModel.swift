import UIKit

class RecordListViewModel: NSObject {
    func fechtRecords(type: String) -> [Estancia]? {
        
        let coreDataManager = CoreDataManager()
        return coreDataManager.recordsList(type: type)
    }
}
