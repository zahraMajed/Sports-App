//
//  PlayersTableViewController.swift
//  Sports App
//
//  Created by admin on 29/12/2021.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    
    var sport: Sports!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //TABEL VIEW METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = sport.players?.count else {
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell")!
        let player = sport.players?[indexPath.row] as! Players
        cell.textLabel?.text = "\(player.playerName ?? ""), Age: \(player.age), Hight: \(player.hight ?? "")"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let player = sport.players?[indexPath.row] as! Players
    
        let alert = UIAlertController(title: "Edit player",message: "Edit player", preferredStyle: .alert)
        
        alert.addTextField { playerName in
            playerName.text = player.playerName
        }
        alert.addTextField{ age in
            age.text = String(player.age)
        }
        alert.addTextField{ hight in
            hight.text = player.hight
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let playerName = alert.textFields![0].text!
            let playerAge = alert.textFields![1].text!
            let playerHight = alert.textFields![2].text!
            let playerArr = [playerName,playerAge,playerHight]
            PlayerEntity.updatePlayerOfSport(playerArr: playerArr, indexP: indexPath.row, player:player)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //VC ACTIONS
    @IBAction func addPlayerBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Player",message: "Add a new player",preferredStyle: .alert)
        
        alert.addTextField { playerName in
            playerName.placeholder = "Enter first and last name"
        }
        alert.addTextField{ age in
            age.placeholder = "Enter player age"
        }
        alert.addTextField{ hight in
            hight.placeholder = "Enter player hight"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let playerName = alert.textFields![0].text!
            let playerAge = alert.textFields![1].text!
            let playerHight = alert.textFields![2].text!
            let playerArr = [playerName,playerAge,playerHight]
            PlayerEntity.addPlayerToSport(sport: self.sport, playerArr: playerArr)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    

}
