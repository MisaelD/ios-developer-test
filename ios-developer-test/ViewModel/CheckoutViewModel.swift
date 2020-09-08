import UIKit
import CoreData

class CheckoutViewModel: NSObject {
    func updateLicensePlate(licensePlate: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<LicensePlateModel> = LicensePlateModel.fetchRequest()
        request.predicate = NSPredicate(format: "placa = %@", licensePlate)
        do {
            let result = try managedContext.fetch(request)
            
            if result.count > 0 {
                let licensePlateModel = result[0]
                licensePlateModel.salida = Date() as NSDate
                try managedContext.save()
                return (true)
            }
            return (false)
        } catch {
            return false
        }
    }
}
