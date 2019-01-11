//
//  MeetingsViewControlelr.swift
//  RCurve
//
//  Created by Sandeep Joshi on 9/30/18.
//  Copyright © 2018 Sandeep Joshi. All rights reserved.
//

import UIKit

class MeetingsViewControlelr: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 35.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
