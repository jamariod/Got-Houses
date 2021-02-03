//
//  SplashScreenViewController.swift
//  Got-Houses
//
//  Created by Jamario Davis on 2/2/21.
//

import UIKit
import AVFoundation

class SplashScreenViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var throneImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playSound(name: "GameOfThrones")
        
        let yAtStart = throneImageView.frame.origin.y
        throneImageView.frame.origin.y = self.view.frame.height
        UIView.animate(withDuration: 1.0, delay: 1.0, animations: {self.throneImageView.frame.origin.y = yAtStart})
    }
    func playSound(name: String) {
        if let sound = NSDataAsset(name: name) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: \(error.localizedDescription). Could not initializer AVAudioPlayer object")
            }
        } else {
            print("ERROR: Could not read data from file \(name)")
        }
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        if audioPlayer != nil {
            audioPlayer.stop()
        }
        performSegue(withIdentifier: "ShowTableView", sender: nil)
    }
}
