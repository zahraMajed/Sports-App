//
//  SportsTableViewController.swift
//  Sports App
//
//  Created by admin on 29/12/2021.
//

import UIKit

class SportsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SportTabelViewCellDelegates {

    var sportsArr = [Sports]()
    var currentIndexP : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsArr = SportEntity.fetchSportEntity()
    }
    
    // TABEL VIEW METHIDS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell") as! SportTableViewCell
        cell.lblSportName.text = sportsArr[indexPath.row].sportName
        cell.delegate = self
        currentIndexP = indexPath.row
        if let jpegImg = sportsArr[indexPath.row].sportImg {
            let sportImg =  UIImage(data: jpegImg)!
            cell.sportImage.image = sportImg
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        SportEntity.deleteSport(sport: sportsArr[indexPath.row])
        self.sportsArr = SportEntity.fetchSportEntity()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let currentSport = sportsArr[indexPath.row]
        let alert = UIAlertController(title: "Edit Sport",message: "Edit sport",preferredStyle: .alert)
        alert.addTextField { sportName in
            sportName.text = currentSport.sportName
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let sportName = alert.textFields![0].text!
            SportEntity.updateSport(updatedSportName: sportName, indexP: indexPath.row)
            self.sportsArr = SportEntity.fetchSportEntity()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSport = sportsArr[indexPath.row]
        performSegue(withIdentifier: "showPlayers", sender: currentSport)
    }
    
    // ACTION
    @IBAction func addSportBtn(_ sender: Any) {
        let alert = UIAlertController(title: "New Sport",message: "Add a new sport",preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let sportName = alert.textFields![0].text!
            SportEntity.addSportToDB(sportName: sportName)
            self.sportsArr = SportEntity.fetchSportEntity()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func openImagePickerControllerForSportCell() {
        getPhoto()
    }

    func getPhoto() {
        print("inside getPhoto()")
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage {
            let jpegImg = img.jpegData(compressionQuality: 1.0)
            SportEntity.updateSportImg(jpegImg: jpegImg!, indexP: currentIndexP!)
            self.sportsArr = SportEntity.fetchSportEntity()
            self.tableView.reloadData()
            print("img assigned")
        }else {
            print("img not found")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // PREPARE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayers" {
            let playerVC = segue.destination as! PlayersTableViewController
            playerVC.sport = sender as? Sports
        }
    }
}

