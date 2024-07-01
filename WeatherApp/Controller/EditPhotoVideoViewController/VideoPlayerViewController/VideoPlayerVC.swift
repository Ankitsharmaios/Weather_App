//
//  VideoPlayerVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 01/07/24.
//

import UIKit
import AVFoundation

class VideoPlayerVC: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var videoView: UIImageView!
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnStopVideo: UIButton!
    @IBOutlet weak var innerstopBtnView: UIView!
    var selectedmessages: Message?
    var playerAV: AVPlayer?
    var isPlaying: Bool = true
    var hideTimer: Timer?
    
    class func getInstance()-> VideoPlayerVC {
        return VideoPlayerVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
        
               // Play the video
               if let mediaURL = selectedmessages?.mediaURL, let videoURL = URL(string: mediaURL) {
                   playerAV = AVPlayer(url: videoURL)
                   let playerLayerAV = AVPlayerLayer(player: playerAV)
                   playerLayerAV.frame = self.videoView.bounds
                   self.videoView.layer.addSublayer(playerLayerAV)
                   playerAV?.play()
                   
                   // Start the timer to hide properties after 2 seconds
                hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideProperties), userInfo: nil, repeats: false)
               }
        
             // Add tap gesture recognizer to the view
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                self.view.addGestureRecognizer(tapGestureRecognizer)

//        // Add share button
//        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareVideo))
//        navigationItem.rightBarButtonItem = shareButton
        
    }
//    @objc func shareVideo() {
//            guard let mediaURL = selectedmessages?.mediaURL, let videoURL = URL(string: mediaURL) else {
//                print("Invalid URL")
//                return
//            }
//            
//            let activityViewController = UIActivityViewController(activityItems: [videoURL], applicationActivities: nil)
//            activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // For iPad compatibility
//            
//            present(activityViewController, animated: true, completion: nil)
//        }
    
    func setUpUI()
    {
        lblName.font = Helvetica.helvetica_regular.font(size: 15)
        lblName.textColor = appThemeColor.white
        
        lblDateTime.font = Helvetica.helvetica_regular.font(size: 12)
        lblDateTime.textColor = appThemeColor.white
        
        lblStartTime.font = Helvetica.helvetica_regular.font(size: 15)
        lblStartTime.textColor = appThemeColor.white
        
        lblEndTime.font = Helvetica.helvetica_regular.font(size: 15)
        lblEndTime.textColor = appThemeColor.white
        
        innerstopBtnView.layer.cornerRadius = innerstopBtnView.layer.frame.width / 2
        innerstopBtnView.clipsToBounds = true
        
    }
    
    @objc func hideProperties() {
            progressView.isHidden = true
            timerView.isHidden = true
            topView.isHidden = true
            innerstopBtnView.isHidden = true
        }
    
    @objc func handleTap() {
           // Toggle the visibility of the properties
           let isHidden = progressView.isHidden
           progressView.isHidden = !isHidden
           timerView.isHidden = !isHidden
           topView.isHidden = !isHidden
           btnMoreOption.isHidden = !isHidden
           btnForward.isHidden = !isHidden
           lblStartTime.isHidden = !isHidden
           lblEndTime.isHidden = !isHidden
           btnStopVideo.isHidden = !isHidden
           innerstopBtnView.isHidden = !isHidden
           // Reset the timer if properties are shown
           if !isHidden {
               hideTimer?.invalidate()
               hideTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(hideProperties), userInfo: nil, repeats: false)
           }
       }
    
    
    
    
    
    @IBAction func forwardAction(_ sender: Any)
    {
        
    }
    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
    @IBAction func stopVideoAction(_ sender: Any) 
    {
        if isPlaying {
                   playerAV?.pause()
                   innerstopBtnView.isHidden = false
               } else {
                   playerAV?.play()
                   innerstopBtnView.isHidden = true
               }
               isPlaying.toggle()
    }
    @IBAction func moreOptionAction(_ sender: Any)
    {
        
    }
    
}
