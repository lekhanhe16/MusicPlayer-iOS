//
//  DAO.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 12/02/2023.
//

import Foundation
import UIKit.UIApplication
import CoreData

protocol DAO {

    func get(predicate: NSPredicate?) -> [NSManagedObject]
    func insert(value: DEntity)
    func update()
    func delete()
}
