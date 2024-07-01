//
//  LeftImgVideoTableViewCell.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/06/24.
//
import UIKit
import AVFoundation
import Kingfisher
class LeftImgVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgeinnerView: UIView!

    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var shareImgeandVideoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        imgeinnerView.backgroundColor = .white

        imgeinnerView.layer.cornerRadius = 10
        shareImgeandVideoView.layer.cornerRadius = 10
        shareImgeandVideoView.clipsToBounds = true
        playImageView.isHidden = true
    }

    func configure(with mediaURL: String, time: String) {
        guard let url = URL(string: mediaURL) else {
            print("Invalid URL")
            return
        }
        
        // Reset the image view before setting a new image or thumbnail
        shareImgeandVideoView.image = UIImage(named: "Place_Holder")
        
        // Check if the URL is a video (MP4 or MOV)
        if url.pathExtension.lowercased() == "mp4" || url.pathExtension.lowercased() == "mov" {
            // Generate thumbnail image for the video URL
            getThumbnailImage(forUrl: url) { [weak self] (thumbnail) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    // Set the generated thumbnail image to shareImgeandVideoView
                    self.shareImgeandVideoView.image = thumbnail
                    self.playImageView.isHidden = false
                    self.lblTime.text = self.formatTime(time)
                }
            }
        } else {
            // Handle non-video URLs (assume image)
            shareImgeandVideoView.kf.setImage(with: url, placeholder: UIImage(named: "Place_Holder"))
            lblTime.text = formatTime(time)
        }
    }

    private func getThumbnailImage(forUrl url: URL, completion: @escaping (UIImage?) -> Void) {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        // Generate thumbnail image asynchronously
        DispatchQueue.global().async {
            do {
                let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
                let thumbnailImage = UIImage(cgImage: thumbnailCGImage)
                completion(thumbnailImage)
            } catch {
                print("Error generating thumbnail: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    private func formatTime(_ time: String) -> String {
        let timeComponents = time.split(separator: ":")
        if timeComponents.count >= 2 {
            return "\(timeComponents[0]):\(timeComponents[1])"
        }
        return time
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
