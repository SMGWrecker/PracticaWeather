//
//  TempTableViewCell.swift
//  PracticaWeather
//
//  Created by user on 26/11/2020.
//

import UIKit

class TempTableViewCell: UITableViewCell {
    
     
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityTemp: UILabel!
    @IBOutlet weak var iconCityTemp: UIImageView!
    @IBOutlet weak var bacgroundCell: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
