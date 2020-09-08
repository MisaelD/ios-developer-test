import UIKit
import CoreData

class AddVehicleViewModel: NSObject {
    func saveVehicle(license: String, tipo: String, finished: (Bool) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let licensePlateModel = LicensePlateModel(context: managedContext)
        
        //let entity = NSEntityDescription.entity(forEntityName: "Placa", in: managedContext)!
        
        //let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        //formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        //let now = Date()
        //let dateString = formatter.string(from:now)
        //NSLog("%@", dateString)
        
        licensePlateModel.placa = license
        licensePlateModel.tipo = tipo
        
        do {
            try managedContext.save()
            finished(true)
        } catch {
            finished(false)
        }
    }
    
}
