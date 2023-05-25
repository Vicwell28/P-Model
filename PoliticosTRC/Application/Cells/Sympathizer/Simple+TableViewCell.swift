//
//  Simple+TableViewCell.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 24/04/23.
//

import UIKit

class Simple_TableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var lblUnique: UILabel!
}
