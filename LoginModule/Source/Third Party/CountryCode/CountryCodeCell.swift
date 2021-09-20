// 
 //   CountryCodeCell.swift
 //   JOBSTOAPP
 // 
 //   Created by Vinitha on 27/12/18.
 //   Copyright © 2018 Apple. All rights reserved.
 // 

import UIKit

class CountryCodeCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var mapImg: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCountryCode: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
         //  Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

         //  Configure the view for the selected state
    }

}
