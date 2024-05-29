//
//  StatusStoryVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 28/05/24.
//

import UIKit
import SDWebImage
import AVFoundation
import AVKit
import MobileCoreServices
class StatusStoryVC: UIViewController {

    

   
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var btnMoreoption: UIButton!
    @IBOutlet weak var lblStatusTime: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    var timer: Timer?
    var progressIncrement: Float = 0.0
    let totalDuration: TimeInterval = 6.0 // Total duration for the progress to fill (e.g., 5 seconds)
    let updateInterval: TimeInterval = 0.01 // Update interval for the timer (e.g., 20 milliseconds)

    var showTabBar: (() -> Void )?
    var userImg = ""
    var userName = ""
    var userImgStory = ""
    var userVideoStory = ""
    var userStoryTime = ""
    
    
    
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    class func getInstance()-> StatusStoryVC {
        return StatusStoryVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewWillAppear(_ animated: Bool) {
        startProgress()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.0
        progressIncrement = Float(updateInterval / totalDuration)
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressRecognizer.minimumPressDuration = 0.1 // Minimum duration for the long press
        view.addGestureRecognizer(longPressRecognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpUI()
        setUserData()
        // Do any additional setup after loading the view.
//        if userImgStory == ""
//        {
//            storyImageView.isHidden = true
//            videoImageView.isHidden = false
//        }else
//        {
//            storyImageView.isHidden = false
//            videoImageView.isHidden = true
//        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.showTabBar?()
        
    }
    
    func setUpUI()
    {
    
        lblUsername.font = Helvetica.helvetica_regular.font(size: 16)
        lblUsername.textColor = appThemeColor.white
        
        lblStatusTime.font = Helvetica.helvetica_regular.font(size: 12)
        lblStatusTime.textColor = appThemeColor.white

        
        
        textField.attributedPlaceholder =
        NSAttributedString(string: "   Reply", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]) // new_Password : our text feild name
      
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.layer.backgroundColor = appThemeColor.TextView_BackGround.cgColor
        
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = appThemeColor.white.cgColor
    }
    func startProgress() {
            // Invalidate any existing timer
            timer?.invalidate()

            // Create a new timer that fires every updateInterval second
            timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
    func stopProgress() {
           // Invalidate the timer to stop the progress
           timer?.invalidate()
           timer = nil
        
       }

        @objc func updateProgress() {
            // Increment the progress
            progressView.progress += progressIncrement

            // Check if progress is full
            if progressView.progress >= 1.0 {
                // Invalidate the timer
                timer?.invalidate()
                timer = nil

                // Dismiss the view controller after a slight delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            switch gestureRecognizer.state {
            case .began:
                // User has started pressing the screen
                stopProgress()
            case .ended, .cancelled:
                // User has released the screen
                startProgress()
            default:
                break
            }
        }
    
    // Function to adjust the content mode of storyImageView
    func adjustImageView(image: UIImage) {
        // Calculate aspect ratio
        let aspectRatio = image.size.height / image.size.width
        
        // Set content mode based on aspect ratio
        if aspectRatio >= 1.0 {
            // If aspect ratio is greater than or equal to 1 (tall or square image), use aspect fill
            storyImageView.contentMode = .scaleAspectFill
        } else {
            // If aspect ratio is less than 1 (wide image), use aspect fit
            storyImageView.contentMode = .scaleAspectFit
        }
        
        // Update image
        storyImageView.image = image
    }

    func setUserData() {
     
        if userImgStory == ""
        {
            let videoURL = URL(fileURLWithPath: "\(userVideoStory)")
            
            // Create AVPlayer instance
            player = AVPlayer(url: videoURL)
            
            // Create AVPlayerLayer for video display
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = view.bounds
            playerLayer?.videoGravity = .resizeAspectFill
            
            if let playerLayer = playerLayer {
                videoImageView.layer.addSublayer(playerLayer)
            }
            
            // Start playback
            player?.play()
        }else{
            let fileManager = FileManager.default
            let placeholderImage = UIImage(named: "placeholder")

                if fileManager.fileExists(atPath: userImgStory) {
                    let localImageURL = URL(fileURLWithPath: userImgStory)
                    storyImageView.sd_setImage(with: localImageURL, placeholderImage: placeholderImage, options: .highPriority) { [weak self] image, error, cacheType, url in
                        guard let image = image else { return }
                        self?.adjustImageView(image: image)
                    }
                } else if let remoteImageURL = URL(string: userImgStory) {
                    storyImageView.sd_setImage(with: remoteImageURL, placeholderImage: placeholderImage, options: .highPriority) { [weak self] image, error, cacheType, url in
                        guard let image = image else { return }
                        self?.adjustImageView(image: image)
                    }
                } else {
                    storyImageView.image = placeholderImage
                }
            
        }
        
        
        // Set other user data
        let imageURLString = userImg
        lblUsername.text = userName
        
        if let imageURL = URL(string: imageURLString) {
            userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
        } else {
            userImageView.image = UIImage(named: "placeholder")
        }
        
        lblStatusTime.text = userStoryTime
        
        
       
           
           }
    
    @IBAction func backAction(_ sender: Any)
    {
        self.dismiss(animated: true){
            self.showTabBar?()
        }
    }
    
    @IBAction func moreOptionAction(_ sender: Any) {
    }
}
