//
//  CameraVC.swift
//  PhotoVideoEditor
//
//  Created by Faris Albalawi on 11/12/18.
//  Copyright © 2018 Faris Albalawi. All rights reserved.
//

import UIKit
import AVFoundation

protocol GetCameraActionDelegate: AnyObject {
    func skipButtonAction(sender: UIButton)
    func openPhotoLibrary(sender: UIButton)
    func getClickImage(img: UIImage)
    func getVideoUrl(url: URL)
}

class CameraVC: SwiftyCamViewController {
    
    @IBOutlet weak var captureButton    : SwiftyRecordButton!
    @IBOutlet weak var flipCameraButton : UIButton!
    @IBOutlet weak var flashButton      : UIButton!
    @IBOutlet weak var btnImages: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnSkipPhotos: UIButton!
    
    weak var cameraActionDelegate: GetCameraActionDelegate?
     
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    class func getInstance()-> CameraVC {
        return CameraVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSkipPhotos.layer.borderWidth = 1.0
        btnSkipPhotos.layer.borderColor = UIColor.white.cgColor
        btnImages.layer.cornerRadius = 8
        btnSkipPhotos.layer.cornerRadius = btnSkipPhotos.frame.height / 2
        btnSkipPhotos.titleLabel?.textColor = .white
        btnSkipPhotos.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoHelper.shared.fetchPhotos()
        videoQuality = .resolution1280x720
        shouldPrompToAppSettings = true
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = false
        allowAutoRotate = true
        audioEnabled = true
        videoGravity = .resizeAspectFill
        // disable capture button until session starts
        captureButton.buttonEnabled = true
        
        if !PhotoHelper.shared.images.isEmpty {
            btnImages.setImage(PhotoHelper.shared.images[0], for: .normal)
        } else {
            btnImages.setImage(UIImage(named: "ic_img_placeholder"), for: .normal)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButton.delegate = self
    }
    
    @IBAction func cameraSwitchTapped(_ sender: Any) {
        switchCamera()
    }
    
    @IBAction func toggleFlashTapped(_ sender: Any) {
        flashEnabled = !flashEnabled
        toggleFlashAnimation()
    }
    
    @IBAction func onImagesTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
        cameraActionDelegate?.openPhotoLibrary(sender: sender)
    }
    
    @IBAction func onCloseTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onBtnSkipPhotos(_ sender: UIButton) {
        self.dismiss(animated: true)
        cameraActionDelegate?.skipButtonAction(sender: sender)
    }
    
}


// UI Animations
extension CameraVC {
    
    fileprivate func hideButtons() {
        UIView.animate(withDuration: 0.25) {
            self.flashButton.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
        }
    }
    
    fileprivate func showButtons() {
        UIView.animate(withDuration: 0.25) {
            self.flashButton.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
        }
    }
    
    fileprivate func focusAnimationAt(_ point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }) { (success) in
                focusView.removeFromSuperview()
            }
        }
    }
    
    fileprivate func toggleFlashAnimation() {
        if flashEnabled == true {
            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControl.State())
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControl.State())
        }
    }
}


extension CameraVC : SwiftyCamViewControllerDelegate {
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did start running")
        captureButton.buttonEnabled = true
    }
    
    func swiftyCamSessionDidStopRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did stop running")
        captureButton.buttonEnabled = false
    }
    
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        print("ClickPhotos", photo)
        self.dismiss(animated: true) {
            self.cameraActionDelegate?.getClickImage(img: photo)
        }
        //        let newVC = PhotoViewController(image: photo)
        //        self.present(newVC, animated: true, completion: nil)
        //
        
        
        //        let storyboard = UIStoryboard(name: "PhotoEditor", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "PhotoEditorViewController") as! PhotoEditorViewController
        //        vc.photo = photo
        //        vc.checkVideoOrIamge = true
        //
        //        for i in 100...110 {
        //            vc.stickers.append(UIImage(named: i.description )!)
        //        }
        //
        //        present(vc, animated: false, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did Begin Recording")
        captureButton.growButton()
        hideButtons()
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
        captureButton.shrinkButton()
        showButtons()
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        print("Video Url", url)
        self.dismiss(animated: true)
        cameraActionDelegate?.getVideoUrl(url: url)
        //        let storyboard = UIStoryboard(name: "PhotoEditor", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "PhotoEditorViewController") as! PhotoEditorViewController
        //        vc.videoURL = url
        //        vc.checkVideoOrIamge = false
        //
        //        for i in 100...110 {
        //            vc.stickers.append(UIImage(named: i.description )!)
        //        }
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: false, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        print("Did focus at point: \(point)")
        focusAnimationAt(point)
    }
    
    func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController) {
        let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
        let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print("Zoom level did change. Level: \(zoom)")
        print(zoom)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print("Camera did change to \(camera.rawValue)")
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }
}
