//
//  RecordListViewModel.swift
//  ios-developer-test
//
//  Created by PorMientras on 07/09/20.
//  Copyright © 2020 Misael Delgado Saucedo. All rights reserved.
//

import UIKit
import CoreData

class RecordListViewModel: NSObject {

    func fechtRecords() -> [LicensePlateModel]? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<LicensePlateModel> = LicensePlateModel.fetchRequest()
        do {
            let result = try managedContext.fetch(request)
            return (result)
        } catch {
            return nil
        }
    }
}
