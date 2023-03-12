//
//  PlayListDAO.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 12/02/2023.
//

import Foundation
import CoreData
import UIKit.UIApplication

class PlayListDAO: DAO {
    var arrPlaylist: [PlaylistEntity]? = nil
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     func get(predicate: NSPredicate? = nil) -> [NSManagedObject]{
        //let fetchRequest = PlaylistEntity.fetchRequest()
         if arrPlaylist == nil {
             
         }
         else {
             
         }
        return []
    }
    
    func getByPlaylistName(pname: String) -> PlaylistEntity? {
        let fetchRequest = PlaylistEntity.fetchRequest()
        let byNamePredicate = NSPredicate(format: "pname MATCHES %@", pname)
        fetchRequest.predicate = byNamePredicate
        do {
            let result = try context.fetch(fetchRequest)
            print(result)
            return result[0]
        }
        catch {
            print(error)
        }
        
        return nil
    }
    
    func insert(value: DEntity) {
        // TODO
         if let playlist = value as? Playlist {
             let newItem = PlaylistEntity(context: context)
             newItem.pname = playlist.playlistName
             newItem.isFav = playlist.isFav
//             newItem.arrSongs = playlist.arrSongs.map({SongEn})
         }
         
    }
    
     func update() {
        // TODO
    }
    
     func delete() {
        // TODO
    }
}
