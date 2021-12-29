//
//  PlayerEntity.swift
//  Sports App
//
//  Created by admin on 29/12/2021.
//

import UIKit
import CoreData

class PlayerEntity {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func addPlayerToSport(sport:Sports, playerArr:[String]) {
        let newPlayer = Players(context: context)
        newPlayer.playerName = playerArr[0]
        newPlayer.age = Int16(playerArr[1]) ?? 0
        newPlayer.hight = playerArr[2]
        sport.addToPlayers(newPlayer)
        savePlayer()
    }
    
    static func updatePlayerOfSport(playerArr:[String],indexP:Int, player:Players){
        do {
            let playerName = player.playerName
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
            let reqPredicate = NSPredicate(format: "playerName == %@", playerName!)
            fetchRequest.predicate = reqPredicate
            let player = try context.fetch(fetchRequest) as! [Players]
           
            player[indexP].playerName = playerArr[0]
            player[indexP].age = Int16(playerArr[1]) ?? 0
            player[indexP].hight = playerArr[2]
            savePlayer()
        }catch {
            print("===Error updateTaks Function===")
        }
    }
    
    
    static func savePlayer() {
        if context.hasChanges {
            do {
                try context.save()
                print("Successfully saved")
            } catch {
                print("Error when saving: \(error)")
            }
        }
    }
    
}
