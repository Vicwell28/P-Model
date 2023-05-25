//
//  Miembro+TableViewCell.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

import UIKit

class Miembro_TableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgCell.setCircle()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var btnCell: UIButton!
    @IBOutlet weak var lblSymp: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
}
