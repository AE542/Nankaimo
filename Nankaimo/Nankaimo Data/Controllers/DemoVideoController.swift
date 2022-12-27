//
//  DemoVideoController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2022/12/11.
//

import UIKit
import AVKit
import AVFoundation
//need these two frameworks for video playback

//2022/12/21 Create a frame the view controller is in. So the way this was done is having a separate view

class DemoVideoController: UIViewController {
    
    @IBOutlet weak var howToUseTitle: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    
    let avPlayerController = AVPlayerViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        howToUseTitle.text = "Demonstration"
        howToUseTitle.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        howToUseTitle.layer.borderWidth = 2.5
        howToUseTitle.layer.cornerRadius = 10.0
        howToUseTitle.clipsToBounds = true
        
        videoView.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        videoView.layer.borderWidth = 2.5
        videoView.layer.cornerRadius = 10.0
        videoView.clipsToBounds = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playDemoVideo()
    }
    
    //Can have this play from a url. Or can make it as a local file but that will increase the file size. Will try both ways.
    
    
    func playDemoVideo() {

        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "NankaimoDemo", ofType: "mp4")!)
                  //create an instance of AVPlayer passing it the HTTP URL
          let player = AVPlayer(url: url)
         //ADD THE VIDEO TO TARGETS OTHERWISE IT WILL KEEP COMING BACK AS NIL AND CRASHING
        avPlayerController.player = player
        
        avPlayerController.view.frame.size.height = videoView.frame.size.height
        avPlayerController.view.frame.size.width = videoView.frame.size.width
          
        videoView.addSubview(avPlayerController.view)

          player.play()
        
    }
    
    
}
