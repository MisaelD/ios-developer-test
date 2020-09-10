import UIKit

class ResidentPayViewModel: NSObject {
    
    func sumDurationMonth(fileName: String) {
        
        let coreDataManager = CoreDataManager()
        let dictionary = coreDataManager.sumDurationOfMonth()
        let fileTextManager = FileTxtManager()
        fileTextManager.generateFileAndWrite(fileName: fileName, dictionary: dictionary!)
        
    }
}
