//
//  SportEntity.swift
//  Sports App
//
//  Created by admin on 29/12/2021.
//

import Foundation
import CoreData
import UIKit

class SportEntity {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func addSportToDB(sportName: String) {
        let newSport = Sports(context: context)
        newSport.sportName = sportName
        saveSport()
    }
    
    static func deleteSport(sport:Sports){
        context.delete(sport)
        saveSport()
    }
    
    static func updateSport(updatedSportName:String, indexP:Int){
        do {
            let sportsArr = try context.fetch(Sports.fetchRequest())
            sportsArr[indexP].sportName = updatedSportName
            saveSport()
        }catch {
            print("===Error updateTaks Function===")
        }
    }
    
    static func updateSportImg(jpegImg: Data, indexP: Int){
        do {
           let sportsArr = try context.fetch(Sports.fetchRequest())
            sportsArr[indexP].sportImg = jpegImg
            saveSport()
        }catch {
            print("===Error updateTaks Function===")
        }
    }

    static func saveSport() {
        if context.hasChanges {
            do {
                try context.save()
                print("Successfully saved")
            } catch {
                print("Error when saving: \(error)")
            }
        }
    }

    static func fetchSportEntity() -> [Sports]{
        var sportArr: [Sports] = []
        do {
            sportArr = try context.fetch(Sports.fetchRequest())
            print("Success")
            return sportArr
        } catch {
            print("Error: \(error)")
        }
        return sportArr
    }
    
}
