//
//  EditImageVC.swift
//  WhatsappPhoto
//
//  Created by PC on 22/09/22.
//

import UIKit
import AVFoundation
import ColorPicKit
import Kingfisher
import IQKeyboardManagerSwift

class EditImageVC: BaseViewController {
    
    @IBOutlet weak var constBottom: NSLayoutConstraint!
    @IBOutlet weak var imgTopShadow: UIImageView!
    @IBOutlet weak var imgBottomShadow: UIImageView!
    
    @IBOutlet weak var txtTaskTitle: UITextField!
    
    @IBOutlet weak var btnDraw: UIButton!
    @IBOutlet weak var btnTextAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var btnAddText: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var clvImagesList: UICollectionView!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var viewAdd: UIView!
    @IBOutlet weak var constAddview: NSLayoutConstraint!
    
    
    @IBOutlet weak var colorPicker: HueSlider!
    
    
    @IBOutlet weak var viewToolBar: UIView!
    @IBOutlet weak var viewDone: UIView!
    @IBOutlet weak var stkChatAndImgList: UIStackView!
    @IBOutlet weak var deleteView: UIView!
    
    
    @IBOutlet weak var canvasView: UIView!
    //To hold the image
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    //To hold the drawings and stickers
    @IBOutlet weak var canvasImageView: UIImageView!
    @IBOutlet weak var stkTool: UIStackView!
    
    let HARIZONTAL_SPCE_IMAGE: CGFloat          = 0
    let VERTICAL_SPCE_IMAGE: CGFloat            = UIScreen.main.bounds.height * 5 / 812
    let COLUMN_IMAGE: CGFloat                   = UIScreen.main.bounds.height * 6.5 / 812
    
    var selectedImageIndex = 0
    var currentMode: Mode = .none
    
    var drawColor: UIColor = UIColor.red
    var textViewTextColor: UIColor = UIColor.green
    
    var isDrawing: Bool = false
    var lastPoint: CGPoint!
    var swiped = false
    var isTyping: Bool = false
    var imageViewToPan: UIImageView?
    var stickersVCIsVisible = false
    var lastPanPoint: CGPoint?
    var lastTextViewTransform: CGAffineTransform?
    var lastTextViewTransCenter: CGPoint?
    var lastTextViewFont:UIFont?
    var activeTextView: UITextView?
    var arrEditPhoto = [EditPhotoModel]()
    var arrLinesModel = [PointModel]()
    var didTapClose: (()->())?
    var callback: ((String) -> Void)?
    var imagePath = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        IQKeyboardManager.shared.enable = false
//        IQKeyboardManager.shared.disabledToolbarClasses.append(EditImageVC.self)
        IQKeyboardManager.shared.disabledDistanceHandlingClasses.append(EditImageVC.self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewMessage.layer.cornerRadius = viewMessage.frame.height / 2
        viewAdd.layer.cornerRadius = 4
        let width: CGFloat = (UIScreen.main.bounds.width - ((COLUMN_IMAGE - 1) * HARIZONTAL_SPCE_IMAGE)) / COLUMN_IMAGE
        constAddview.constant = width
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        DispatchQueue.main.async { [self] in
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.clvImagesList.isHidden = true
                self.viewAdd.isHidden = true
                if constBottom.constant == 5{
                    constBottom.constant = keyboardSize.height - 25
                    view.layoutIfNeeded()
                    view.setNeedsLayout()
                    
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        DispatchQueue.main.async { [self] in
            if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.clvImagesList.isHidden = false
                self.viewAdd.isHidden = false
                if constBottom.constant != 5 {
                    constBottom.constant = 5
                    view.layoutIfNeeded()
                    view.setNeedsLayout()
                }
            }
        }
    }
    
    func setupUI() {
        setupClv()
        loadImageandVideo(index: selectedImageIndex)
        loadTextView(index: selectedImageIndex)
        print(arrEditPhoto)
        colorPicker.transform = .init(rotationAngle: 270 * .pi/180)
        drawColor = colorPicker.color
        textViewTextColor = colorPicker.color
    }
    
    func setupClv() {
        clvImagesList.register(UINib(nibName: "ImgListCell", bundle: nil), forCellWithReuseIdentifier: "ImgListCell")
        clvImagesList.dataSource = self
        clvImagesList.delegate = self
        clvImagesList.contentInset = .init(top: 0, left: 0, bottom: 0, right: 15)
        clvImagesList.reloadData()
    }
    
    
    func loadImageandVideo(index: Int) {
        guard index >= 0 && index < arrEditPhoto.count else {
            return
        }
        
        let model = arrEditPhoto[index]
        
        if model.isPhoto {
            // Handling Photo
            btnDraw.isHidden = false
            btnTextAdd.isHidden = false
            btnDelete.isHidden = false
            
            if let image = model.image {
                // Use image directly
                setImage(image: image)
                loadTextView(index: index)
                
                if let imagePath = saveImageToDocumentsDirectory(image: image) {
                    print("Image path:", imagePath)
                    self.imagePath = imagePath
                }
                
                if model.lines?.count ?? 0 > 0 {
                    self.arrLinesModel = model.lines!
                    self.drawLineFrom()
                }
            }
            
        } else {
            // Handling Video
            btnDraw.isHidden = true
            btnTextAdd.isHidden = true
            btnDelete.isHidden = false
            
            if let videoUrl = model.videoUrl {
                DispatchQueue.main.async {
                    let videoView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                    videoView.loadVideo(with: videoUrl)
                    self.canvasView.addSubViewWithAutolayout(subView: videoView)
                    
                    // Optionally, get video path if needed
                    let videoPath = videoUrl.path
                    self.imagePath = videoPath
                    print("Video path:", videoPath)
                }
            }
        }
    }

    func saveImageToDocumentsDirectory(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("image.jpg")
        
        do {
            try imageData.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Error saving image:", error)
            return nil
        }
    }

    
//    func loadImageandVideo(index: Int) {
//        if arrEditPhoto.count == 0 {
//            btnDraw.isHidden = true
//            btnTextAdd.isHidden = true
//            btnDelete.isHidden = true
//            return }
//        resetView()
//        let model = arrEditPhoto[index]
//        if model.isPhoto {
//            print("Photo")
//            btnDraw.isHidden = false
//            btnTextAdd.isHidden = false
//            btnDelete.isHidden = false
//            
//            setImage(image: model.image ?? UIImage())
//            loadTextView(index: index)
//            
//            DispatchQueue.main.asyncAfter(deadline:  .now() + 0.30) {
//                if model.lines?.count ?? 0 > 0 {
//                    self.arrLinesModel = model.lines!
//                        self.drawLineFrom()
//                }
//            }
//        } else {
//            print("Video")
//            btnDraw.isHidden = true
//            btnTextAdd.isHidden = true
//            btnDelete.isHidden = false
//            
//            DispatchQueue.main.async {
//                let videoView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//                videoView.loadVideo(with: model.videoUrl!)
//                self.canvasView.addSubViewWithAutolayout(subView: videoView)
//            }
//        }
//    }
    
    func setImage(image: UIImage) {
        imageView.image = image
        let size = image.suitableSize(widthLimit: UIScreen.main.bounds.width)
        imageViewHeightConstraint.constant = (size?.height)!
    }
    
    
    func loadTextView(index: Int) {
        if arrEditPhoto.count == 0 { return }
        self.canvasImageView.image = UIImage()
        for subview in canvasImageView.subviews {
            subview.removeFromSuperview()
        }
        
        let model = arrEditPhoto[index]
        if model.isPhoto {
            if let vc = model.textViews {
                for i in vc {
                    canvasImageView.addSubview(i)
                }
                self.canvasImageView.setNeedsDisplay()
            }
        }
    }
    
    func resetView() {
        stkTool.isHidden = arrEditPhoto.count == 0 ? true:false
        self.arrLinesModel = [PointModel]()
        self.canvasImageView.image = UIImage()
        self.imageView.image = UIImage()
        for subview in canvasImageView.subviews {
            subview.removeFromSuperview()
        }
        for subview in canvasView.subviews {
            if subview is VideoPlayerView {
                subview.removeFromSuperview()
            }
        }
    }
    
    // MARK: - IBAction
    @IBAction func onBtnDraw(_ sender: UIButton) {
        sender.isSelected.toggle()
        currentMode = sender.isSelected ? .drawMode : .none
        colorPicker.isHidden = false
        isDrawing = sender.isSelected ? true : false
        canvasImageView.isUserInteractionEnabled = sender.isSelected ? false : true
        viewToolBar.isHidden = sender.isSelected ? true : false
        stkChatAndImgList.isHidden = sender.isSelected ? true : false
        viewDone.isHidden = sender.isSelected ? false : true
        btnAddText.isHidden = true
    }
    
    @IBAction func onBtnText(_ sender: UIButton) {
        sender.isSelected.toggle()
        colorPicker.isHidden = false
        currentMode = sender.isSelected ? .textMode : .none
        isTyping = sender.isSelected ? true : false
        canvasImageView.isUserInteractionEnabled = sender.isSelected ? true : false
        viewToolBar.isHidden = sender.isSelected ? true : false
        stkChatAndImgList.isHidden = sender.isSelected ? true : false
        viewDone.isHidden = sender.isSelected ? false : true
        btnAddText.isHidden = sender.isSelected ? false : true
        if sender.isSelected { setupTextFeild() } else {
            view.endEditing(true)
        }
        
    }
    
    @IBAction func onBtnDelete(_ sender: UIButton) {
        if arrEditPhoto.count > 0{
            self.arrEditPhoto.remove(at: selectedImageIndex)
            self.clvImagesList.reloadData()
            let index = selectedImageIndex
            if self.arrEditPhoto.count > index {
                selectedImageIndex = index
                loadImageandVideo(index: selectedImageIndex)
            } else {
                selectedImageIndex = index - 1
                if selectedImageIndex >= 0 {
                    loadImageandVideo(index: selectedImageIndex)
                } else {
                    selectedImageIndex = 0
                    resetView()
                }
            }
        }
    }
    
    @IBAction func onBtnUndo(_ sender: UIButton) {
        if currentMode == .drawMode {
            DispatchQueue.main.async {
                if self.arrLinesModel.count > 0 {
                    self.canvasImageView.image = UIImage()
                    self.arrLinesModel.removeLast()
                    if self.arrLinesModel.count > 0 {
                            DispatchQueue.main.async {
                                self.drawLineFrom()
                            }
                    }
                }
                self.canvasImageView.setNeedsDisplay()
            }
        }
        
        if currentMode == .textMode {
            for subview in canvasImageView.subviews.reversed() {
                subview.removeFromSuperview()
                break
            }
        }
    }
    
    @IBAction func onBtnDone(_ sender: UIButton) {
        if currentMode == .none {
            
        }
        
        if currentMode == .drawMode {
            colorPicker.isHidden = true
            canvasImageView.isUserInteractionEnabled = false
            btnDraw.isSelected = false
            isDrawing = false
            viewToolBar.isHidden = false
            stkChatAndImgList.isHidden = false
            hideToolbar(hide: false)
            viewDone.isHidden =  true
            currentMode = .none
            //save
            self.arrEditPhoto[selectedImageIndex].lines = self.arrLinesModel
            self.arrEditPhoto[selectedImageIndex].doneImage = canvasView.toImage()
        }
        
        if currentMode == .textMode {
            colorPicker.isHidden = true
            canvasImageView.isUserInteractionEnabled = false
            btnTextAdd.isSelected = false
            isTyping = false
            viewToolBar.isHidden = false
            stkChatAndImgList.isHidden = false
            hideToolbar(hide: false)
            viewDone.isHidden =  true
            currentMode = .none
            //save
            if let tv = self.canvasImageView.subviews as? [UITextView] {
                self.arrEditPhoto[selectedImageIndex].textViews = tv
            }
            self.arrEditPhoto[selectedImageIndex].doneImage = canvasView.toImage()
        }
    }
    
    @IBAction func onBtnAddText(_ sender: UIButton) {
        setupTextFeild()
    }
    
    @IBAction func onBtnClose(_ sender: UIButton) {
        didTapClose?()
        self.dismiss(animated: true)
    }
    
    @IBAction func onBtnAddMedia(_ sender: UIButton) {
        setupAndOpenImagePicker()
    }
    
    @IBAction func onBtnSend(_ sender: UIButton) {
        print(arrEditPhoto)
        self.callback?(imagePath)
    }
    
    @IBAction func onColorPickerValueChange(_ sender: HueSlider) {
        if currentMode == .drawMode {
            self.drawColor = sender.color
        }
        if currentMode == .textMode {
            self.textViewTextColor = sender.color
            self.activeTextView?.textColor = sender.color
        }
    }
}

extension EditImageVC {
 
    func hideToolbar(hide: Bool) {
        viewToolBar.isHidden = hide
        stkChatAndImgList.isHidden = hide
    }
    
}

extension EditImageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrEditPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgListCell", for: indexPath) as? ImgListCell else { return .init() }
        
        cell.viewImage.isHidden = false
        if arrEditPhoto[indexPath.row].isPhoto {
            cell.img.image = arrEditPhoto[indexPath.row].image ?? UIImage()
        } else {
            cell.img.kf.setImage(with: AVAssetImageDataProvider(assetURL: arrEditPhoto[indexPath.row].videoUrl!, seconds: 1))
//            cell.img.image = self.getThumbnailImage(forUrl: arrEditPhoto[indexPath.row].videoUrl!) ?? UIImage()
        }
        cell.setSelectedImage(isSelected: selectedImageIndex == indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedImageIndex == indexPath.row { return }
        loadImageandVideo(index: indexPath.row)
        selectedImageIndex = indexPath.row
        clvImagesList.reloadData()
    }
}

//MARK:- CollectionViewDelegateFlowLayout Method
extension EditImageVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return HARIZONTAL_SPCE_IMAGE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return VERTICAL_SPCE_IMAGE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - ((COLUMN_IMAGE - 1) * HARIZONTAL_SPCE_IMAGE)) / COLUMN_IMAGE
        return CGSize(width: width, height: 50)
    }
}
