//
//  NoteTableViewCell.swift
//  Inviz
//
//  Created by Ritesh Ranka on 2022-10-29.
// 

import UIKit

class NoteTableViewCell: UITableViewCell {

    // Custom cell class to import the labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

