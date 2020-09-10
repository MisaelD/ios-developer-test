import Foundation
import CoreData


extension Estancia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Estancia> {
        return NSFetchRequest<Estancia>(entityName: "Estancia")
    }

    @NSManaged public var entrada: NSDate?
    @NSManaged public var salida: NSDate?
    @NSManaged public var duracion: Float
    @NSManaged public var ofPlaca: Placa?

    func salidaDateFormated() -> String {
        
        if salida == nil {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from:salida! as Date)
        return "Salida: " + dateString
        
    }
    
    func entradaDateFormated() -> String {
        
        if entrada == nil {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from:entrada! as Date)
        return "Entrada: " + dateString
    }
    
    func importe() -> String {
        
        if ofPlaca?.tipo == "No residente" {
            let entradaDate = (entrada?.timeIntervalSinceReferenceDate)!/60
            let salidaDate = (salida?.timeIntervalSinceReferenceDate)!/60
            let diffInMins = salidaDate - entradaDate
            return String(format: "$%.2f", diffInMins * 0.5)
        } else if ofPlaca?.tipo == "Residente" {
            let entradaDate = (entrada?.timeIntervalSinceReferenceDate)!/60
            let salidaDate = (salida?.timeIntervalSinceReferenceDate)!/60
            let diffInMins = salidaDate - entradaDate
            duracion = Float(diffInMins)
            return ""
        } else {
            return "No paga"
        }
    }
}
