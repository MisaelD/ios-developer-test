import UIKit
import CoreData

class CoreDataManager: NSObject {

    private func getManagedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    private func checkRecordExists(entity: String, uniqueIdentity: String) -> Bool {
        let context = getManagedObjectContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "placa = %@", uniqueIdentity)
        var results: [NSManagedObject] = []
        
        do {
            results = try context!.fetch(fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
        
    }
    
    private func checkVehicleParked(licensePlate: String) -> Bool {
        let context = getManagedObjectContext()
        let request: NSFetchRequest<Estancia> = Estancia.fetchRequest()
        request.predicate = NSPredicate(format: "salida = nil AND ANY ofPlaca.placa = %@", licensePlate)
        var results: [Estancia] = []
        do {
            results = try context!.fetch(request)
            
        } catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }
    
    private func getLicesePlate(context: NSManagedObjectContext, licensePlate: String) -> Placa? {
        let request: NSFetchRequest<Placa> = Placa.fetchRequest()
        request.predicate = NSPredicate(format: "placa = %@", licensePlate)
        do {
            let result = try context.fetch(request)
            
            if result.count > 0 {
                return result[0]
            }
            return nil
        } catch {
            return nil
        }
    }
}

extension CoreDataManager {
    
    func saveVehicle(license: String, tipo: String, finished: (Bool) -> Void) {
        
        let recordExist = checkRecordExists(entity: "Placa", uniqueIdentity: license)
        
        if recordExist {
            finished(false)
        } else {
            let context = getManagedObjectContext()
            let licensePlateModel = Placa(context: context!)
            licensePlateModel.placa = license
            licensePlateModel.tipo = tipo
            do {
                try context?.save()
                finished(true)
            } catch {
                finished(false)
            }
        }
        
        
    }
}

extension CoreDataManager {
    func checkInVehicle(licensePlate: String) -> EstatusCoreData {
        let recordExist = checkRecordExists(entity: "Placa", uniqueIdentity: licensePlate)
        if recordExist {
            let vehicleParked = checkVehicleParked(licensePlate: licensePlate)
            
            if vehicleParked {
                return EstatusCoreData.parked
            } else {
                let context = getManagedObjectContext()
                guard let licensePlate = getLicesePlate(context: context!, licensePlate: licensePlate) else {
                    return EstatusCoreData.error
                }
                
                let estancia = Estancia(context: context!)
                estancia.entrada = Date() as NSDate
                licensePlate.addToEstancia(estancia)
                do {
                    try context?.save()
                    return EstatusCoreData.success
                } catch {
                    return EstatusCoreData.error
                }
            }
        } else {
            return EstatusCoreData.recordNoExist
        }
    }
}

extension CoreDataManager {
    func recordsList(type: String) -> [Estancia]? {
        let context = getManagedObjectContext()
        let request: NSFetchRequest<Estancia> = Estancia.fetchRequest()
        request.predicate = NSPredicate(format: "ANY ofPlaca.tipo = %@", type)
        do {
            let result = try context?.fetch(request)
            return result
        } catch {
            return nil
        }
    }
}

extension CoreDataManager {
    func checkOutVehicle(licensePlate: String) -> (EstatusCoreData, Estancia?) {
        let context = getManagedObjectContext()
        let request: NSFetchRequest<Estancia> = Estancia.fetchRequest()
        request.predicate = NSPredicate(format: "salida = nil AND entrada != nil AND ANY ofPlaca.placa = %@", licensePlate)
        do {
            let result = try context?.fetch(request)
            
            if result!.count > 0 {
                let estancia = result![0]
                estancia.salida = Date() as NSDate
                _ = estancia.importe()
                
                do {
                    try context?.save()
                    return (EstatusCoreData.success, estancia)
                } catch {
                    return (EstatusCoreData.error, nil)
                }
            }else {
               return (EstatusCoreData.recordNoExist, nil)
            }
            
        } catch {
            return (EstatusCoreData.error, nil)
        }
    }
}

extension CoreDataManager {
    func vehicleList(type: String) -> [Placa]? {
        let context = getManagedObjectContext()
        let request: NSFetchRequest<Placa> = Placa.fetchRequest()
        request.predicate = NSPredicate(format: "tipo = %@", type)
        do {
            let result = try context?.fetch(request)
            return result
        } catch {
            return nil
        }
    }
}

extension CoreDataManager {
    func deleteRecordsVehicles(type: String) -> Bool{
        let context = getManagedObjectContext()
        let request: NSFetchRequest<Estancia> = Estancia.fetchRequest()
        request.predicate = NSPredicate(format: "salida != nil AND entrada != nil AND ANY ofPlaca.tipo = %@", type)
        do {
            let result = try context?.fetch(request)
            
            for estancias in result! {
                context?.delete(estancias)
            }
            
            do {
                try context?.save()
                return true
            } catch {
                return false
            }
        } catch {
            return false
        }
    }
}

extension CoreDataManager {
    func sumDurationOfMonth() -> [NSDictionary]? {
        let keypathExp1 = NSExpression(forKeyPath: "estancia.duracion")
        let expression = NSExpression(forFunction: "sum:", arguments: [keypathExp1])
        let sumDesc = NSExpressionDescription()
        sumDesc.expression = expression
        sumDesc.name = "sum"
        sumDesc.expressionResultType = .doubleAttributeType
        
        let context = getManagedObjectContext()
        let request = NSFetchRequest<NSDictionary>(entityName:"Placa")
        request.predicate = NSPredicate(format: "tipo = %@", "Residente")
        request.returnsObjectsAsFaults = false
        request.propertiesToGroupBy = ["placa"]
        request.propertiesToFetch = ["placa", sumDesc]
        request.resultType = .dictionaryResultType
        
        do {
            let result = try context?.fetch(request)
            
            print(result as Any)
            dump(result)
            return result
        } catch {
            return nil
        }
    }
}
