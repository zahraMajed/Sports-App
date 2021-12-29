//
//  SportTableViewCell.swift
//  Sports App
//
//  Created by admin on 29/12/2021.
//

import UIKit

class SportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var lblSportName: UILabel!
    var delegate: SportTabelViewCellDelegates?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addImageBtn(_ sender: Any) {
        delegate?.openImagePickerControllerForSportCell()
    }
    
    
}
