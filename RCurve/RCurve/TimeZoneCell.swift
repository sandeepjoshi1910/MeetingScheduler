//
//  TimeZoneCell.swift
//  RCurve
//
//  Created by Sandeep Joshi on 1/29/19.
//  Copyright © 2019 Sandeep Joshi. All rights reserved.
//

import UIKit

class TimeZoneCell: UICollectionViewCell {
    
    @IBOutlet weak var locationName: UILabel!
    
    @IBOutlet weak var timeZoneText: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    weak var delegate : TimeZoneDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        setupDeleteBtn()
    }
    
    func setupView() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize.zero
        self.layer.cornerRadius = 11.0
    }
    
    func setupDeleteBtn() {
        deleteBtn.layer.backgroundColor = UIColor.red.cgColor
        deleteBtn.layer.cornerRadius = 4.0
        deleteBtn.layer.shadowColor = UIColor.red.cgColor
        deleteBtn.layer.shadowRadius = 3.0
        deleteBtn.layer.shadowOpacity = 0.4
        deleteBtn.layer.shadowOffset = CGSize.zero
        deleteBtn.layer.cornerRadius = 5.0
    }
    
    @IBAction func close(_ sender: Any) {
        print("Delete pressed for \(self.locationName.text!)")
        self.delegate!.deleteCell(cell: self)
    }
    
}


protocol TimeZoneDelegateProtocol : class {
    func deleteCell(cell : TimeZoneCell) -> ()
}
