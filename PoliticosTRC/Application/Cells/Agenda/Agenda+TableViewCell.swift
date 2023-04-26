//
//  Agenda+TableViewCell.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 20/04/23.
//

import UIKit

class Agenda_TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var hourEvent: UILabel!
    @IBOutlet weak var dateEvent: UILabel!
    @IBOutlet weak var addressEvent: UILabel!
    @IBOutlet weak var placeEvent: UILabel!
    @IBOutlet weak var titleEvent: UILabel!
}
