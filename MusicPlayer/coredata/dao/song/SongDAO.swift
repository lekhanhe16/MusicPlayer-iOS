//
//  SongDAO.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 12/02/2023.
//

import Foundation
import CoreData
import UIKit.UIApplication

class SongDAO: DAO {
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     func get(predicate: NSPredicate? = nil) -> [NSManagedObject]{
        
        return []
    }
    
     func insert(value: DEntity) {
        // TODO
    }
    
     func update() {
        // TODO
    }
    
     func delete() {
        // TODO
    }
}
