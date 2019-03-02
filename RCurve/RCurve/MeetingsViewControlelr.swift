//
//  MeetingsViewControlelr.swift
//  RCurve
//
//  Created by Sandeep Joshi on 9/30/18.
//  Copyright © 2018 Sandeep Joshi. All rights reserved.
//

import UIKit

class MeetingsViewControlelr: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var addNewMeetingBtn: UIButton!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = meetingcv.dequeueReusableCell(withReuseIdentifier: "meetingview", for: indexPath) as! MeetingViewCell
        return cell
    }
    

    @IBOutlet weak var meetingcv: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        meetingcv.register(UINib(nibName: "MeetingViewCell", bundle: nil), forCellWithReuseIdentifier: "meetingview")
        meetingcv.dataSource = self
        meetingcv.delegate = self
        meetingcv.contentInset = UIEdgeInsets(top: 20.0, left: 0, bottom: 20.0, right: 0)
        
        // Adding Border to the Add New Meeting Button
        self.addNewMeetingBtn.layer.borderColor = UIColor.red.cgColor
        self.addNewMeetingBtn.layer.borderWidth = 0.5
        self.addNewMeetingBtn.layer.cornerRadius = 4.0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 35.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35.0
    }
    

    @IBAction func addNewMeeting(_ sender: Any) {
        
        let timeZonePickVC = self.storyboard?.instantiateViewController(withIdentifier: "timeZonePicker")
        present(timeZonePickVC!, animated: true, completion: nil)
    }
    

}
