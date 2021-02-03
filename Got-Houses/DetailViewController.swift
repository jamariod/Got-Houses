//
//  DetailViewController.swift
//  Got-Houses
//
//  Created by Jamario Davis on 2/2/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionImageView: UIImageView!
    @IBOutlet weak var coatOfArmsTextView: UITextView!
    @IBOutlet weak var coatOfArmsLabel: UILabel!
    
    var houseInfo: HouseInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if houseInfo == nil {
            houseInfo = HouseInfo(name: "", region: "", coatOfArms: "", words: "")
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        nameLabel.text = houseInfo.name
        wordsLabel.text = houseInfo.words
        if wordsLabel.text != "" {
            wordsLabel.text = "\"\(houseInfo.words)\""
        }
        regionLabel.text = houseInfo.region
        regionImageView.image = UIImage(named: houseInfo.region)
        coatOfArmsTextView.text = houseInfo.coatOfArms
        if coatOfArmsTextView.text == "" {
            coatOfArmsLabel.isHidden = true
        }
    }

}
