//
//  TimeZoneCell.swift
//  RCurve
//
//  Created by Sandeep Joshi on 1/29/19.
//  Copyright © 2019 Sandeep Joshi. All rights reserved.
//

import UIKit

class TimeZoneCell: UICollectionViewCell {
    
    @IBOutlet weak var removeBtn: UIButton!
    
    @IBOutlet weak var locationName: UILabel!
    
    @IBOutlet weak var timeZoneText: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize.zero
        self.layer.cornerRadius = 15.0

    }
    
    @IBAction func removeTImeZone(_ sender: Any) {
        
        
    }
    

}
