import Foundation
import CoreData


extension Placa {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Placa> {
        return NSFetchRequest<Placa>(entityName: "Placa")
    }

    @NSManaged public var placa: String?
    @NSManaged public var tipo: String?
    @NSManaged public var estancia: NSSet?

}

// MARK: Generated accessors for estancia
extension Placa {

    @objc(addEstanciaObject:)
    @NSManaged public func addToEstancia(_ value: Estancia)

    @objc(removeEstanciaObject:)
    @NSManaged public func removeFromEstancia(_ value: Estancia)

    @objc(addEstancia:)
    @NSManaged public func addToEstancia(_ values: NSSet)

    @objc(removeEstancia:)
    @NSManaged public func removeFromEstancia(_ values: NSSet)

}
