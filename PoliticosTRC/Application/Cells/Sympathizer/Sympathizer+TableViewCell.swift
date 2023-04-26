//
//  Sympathizer+TableViewCell.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

import UIKit

class Sympathizer_TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgCell.setCircle()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        
    }
    
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelMonth: UILabel!
    
    
}
