//
//  InnerCell.swift
//  Stories
//
//  Created by Mahavirsinh Gohil on 19/12/18.
//  Copyright © 2018 Mahavirsinh Gohil. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
protocol ImageZoomDelegate: AnyObject {
    func imageZoomStart()
    func imageZoomEnd()
}

class InnerCell: UICollectionViewCell {
    
    weak var delegate: ImageZoomDelegate?
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    @IBOutlet weak var scrollV: UIScrollView!
    @IBOutlet weak var imgStory: UIImageView!
    
    private var isImageDragged:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollV.isScrollEnabled = false
        scrollV.maximumZoomScale = 3.0;
        scrollV.minimumZoomScale = 1.0;
        scrollV.clipsToBounds = true;
        scrollV.delegate = self
        scrollV.addSubview(imgStory)
    }

func setImageOrVideo(_ mediaString: String, isVideo: Bool) {
     if isVideo {
         playVideo(mediaString)
     } else {
         setImage(mediaString)
     }
 }
 
 private func playVideo(_ videoString: String) {
     guard let url = URL(string: videoString) else { return }
     
     player = AVPlayer(url: url)
     playerLayer?.removeFromSuperlayer()
     
     playerLayer = AVPlayerLayer(player: player)
     playerLayer?.frame = imgStory.bounds
     playerLayer?.videoGravity = .resizeAspectFill
     playerLayer?.contentsGravity = .center
     if let playerLayer = playerLayer {
         imgStory.layer.addSublayer(playerLayer)
     }
     
     player?.play()
 }
    
    func pauseVideo() {
           player?.pause()
       }
       
       func resumeVideo() {
           player?.play()
       }
 
 private func setImage(_ imageString: String) {
     if let url = URL(string: imageString) {
         self.imgStory.sd_setImage(with: url, completed: { [weak self] (image, error, cacheType, imageURL) in
             guard let self = self else { return }
             if let _ = error {
                 self.imgStory.image = nil
             }
             self.isImageDragged = false
             self.setContentMode()
         })
     } else {
         let bundleImage = UIImage(named: imageString)
         self.imgStory.image = bundleImage
         self.isImageDragged = false
         self.setContentMode()
     }
 }

 private func setContentMode() {
     guard let image = imgStory.image else { return }
     
     switch image.imageOrientation {
     case .up:
         imgStory.contentMode = .scaleAspectFit
     case .left, .right:
         imgStory.contentMode = .scaleAspectFill
     default:
         imgStory.contentMode = .scaleAspectFit
     }
 }

 private func resetImage() {
     UIView.animate(withDuration: 0.3, animations: {
         self.scrollV.zoomScale = 1.0
     }) { [weak self] (isAnimationDone) in
         if isAnimationDone {
             self?.delegate?.imageZoomEnd()
             self?.isImageDragged = false
         }
     }
 }
}

// MARK: - Scroll View Data Source and Delegate
extension InnerCell: UIScrollViewDelegate {
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        delegate?.imageZoomStart()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isImageDragged = true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgStory
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if !isImageDragged {
            resetImage()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        resetImage()
    }
}
