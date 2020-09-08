//
//  Placa+CoreDataProperties.swift
//  ios-developer-test
//
//  Created by PorMientras on 08/09/20.
//  Copyright © 2020 Misael Delgado Saucedo. All rights reserved.
//
//

import Foundation
import CoreData


extension LicensePlateModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LicensePlateModel> {
        return NSFetchRequest<LicensePlateModel>(entityName: "Placa")
    }

    @NSManaged public var placa: String?
    @NSManaged public var entrada: NSDate?
    @NSManaged public var salida: NSDate?
    @NSManaged public var tipo: String?
    
    func salidaDateFormated() -> String {
        
        if salida == nil {
            return ""
        }
        
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //let now = Date()
        let dateString = formatter.string(from:salida! as Date)
        return "Salida: " + dateString
        
    }
    
    func entradaDateFormated() -> String {
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //let now = Date()
        let dateString = formatter.string(from:entrada! as Date)
        return "Entrada: " + dateString
    }

}
