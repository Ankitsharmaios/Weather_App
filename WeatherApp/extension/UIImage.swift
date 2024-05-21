//
//  UIImage.swift
//  UniviaFarmer
//
//  Created by Nikunj on 1/20/23.
//

import Foundation
import UIKit
import AVKit
import SDWebImage

extension UIImageView {
    func getImage(_ urlString: String) {
        if let url = URL(string: urlString) {
            self.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_icon.png"))
        }
        else{
            self.image = UIImage(named: "placeholder_icon")
        }
    }
    func getImageWithSmallPlaceHolder(_ urlString: String) {
        if let url = URL(string: urlString) {
            self.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_crops.png"))
        }
        else{
            self.image = UIImage(named: "ic_crops")
        }
    }
}

func generateThumbnail(path: URL) -> UIImage? {
    do {
        let asset = AVURLAsset(url: path, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        imgGenerator.appliesPreferredTrackTransform = true
        let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
        let thumbnail = UIImage(cgImage: cgImage)
        return thumbnail
    } catch let error {
        print("*** Error generating thumbnail: \(error.localizedDescription)")
        return UIImage(named: "placeholder_icon.png")
    }
}
