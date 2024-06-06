//
//  ViewController.swift
//  Stories
//
//  Created by Mahavirsinh Gohil on 16/10/17.
//  Copyright © 2017 Mahavirsinh Gohil. All rights reserved.
//

import UIKit
import SDWebImage
class StoryViewController: UIViewController & UITextViewDelegate {


    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var textDataShowLbl: UILabel!
    @IBOutlet weak var textStoryView: UIView!
    @IBOutlet weak var btnMoreOption: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var outerCollection: UICollectionView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var seenStoriesCount: Int = 0
    
    var rowIndex:Int = 0
    var arrUser = [StoryHandler]()
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    var imageCollection: [[String]]!
    var contactStoriesData: StoryResultModel?
    var selectedRowIndex: Int?
    var tapGest: UITapGestureRecognizer!
    var longPressGest: UILongPressGestureRecognizer!
    var panGest: UIPanGestureRecognizer!
    private let placeholderLabel: UILabel = {
            let label = UILabel()
            label.text = "Reply"
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    var seenStoryCount = 0
    var showTabBar: (() -> Void)?
    var callback: ((Int) -> Void)?
    class func GetInstance()-> StoryViewController {
        return StoryViewController.viewController(storyboard: Constants.Storyboard.DashBoard)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        cancelBtn.addTarget(self, action: #selector(cancelBtnTouched), for: .touchUpInside)
        setupModel()
        setUpUI()
        addGesture()
        setupPlaceholder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        callback?(seenStoryCount)
    }
    
    func setUpUI()
    {
        
        replyTextView.delegate = self
        
        replyTextView.layer.cornerRadius = 20
        replyTextView.clipsToBounds = true
        replyTextView.backgroundColor = appThemeColor.TextView_BackGround
        replyTextView.font = Helvetica.helvetica_regular.font(size: 15)
        replyTextView.textColor = appThemeColor.white
        
      
        textStoryView.isHidden = true
        textDataShowLbl.isHidden = true
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.layer.borderWidth = 1.5
        userImageView.layer.borderColor  = appThemeColor.white.cgColor
        userImageView.clipsToBounds = true
        
        nameLbl.text = contactStoriesData?.userName ?? ""
        updateTimeLabel(for: 0)
        let imageURLString = contactStoriesData?.userImage
        
        if let imageURL = URL(string: imageURLString ?? "") {
            userImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
        } else {
            userImageView.image = UIImage(named: "placeholder")
        }
        
        if let firstMedia = contactStoriesData?.media?.first {
                if let textBackground = firstMedia.textBackground,
                   let color = UIColor(hex: textBackground) {
                    textStoryView.isHidden = false
                    textStoryView.backgroundColor = color
                }
                
                if let textData = firstMedia.text {
                    textDataShowLbl.font = Helvetica.helvetica_bold.font(size: 15)
                    textDataShowLbl.textColor = appThemeColor.white
                    textDataShowLbl.isHidden = false
                    textDataShowLbl.text = textData
                }
            }
        
        
    }
    private func setupPlaceholder() {
           replyTextView.addSubview(placeholderLabel)
           
           NSLayoutConstraint.activate([
               placeholderLabel.leadingAnchor.constraint(equalTo: replyTextView.leadingAnchor, constant: 5),
               placeholderLabel.topAnchor.constraint(equalTo: replyTextView.topAnchor, constant: 8),
               placeholderLabel.widthAnchor.constraint(equalTo: replyTextView.widthAnchor, multiplier: 0.8)
           ])
           
           placeholderLabel.isHidden = !replyTextView.text.isEmpty
       }
       
       func textViewDidChange(_ textView: UITextView) {
           placeholderLabel.isHidden = !replyTextView.text.isEmpty
          // adjustTextViewHeight()
       }

//    private func adjustTextViewHeight() {
//        let size = CGSize(width: replyTextView.frame.width, height: .infinity)
//        let estimatedSize = replyTextView.sizeThatFits(size)
//
//        // Calculate the height of one line of text
//        let oneLineHeight = replyTextView.font?.lineHeight ?? 0
//
//        // Check if the height exceeds the height of one line of text
//        if estimatedSize.height > oneLineHeight {
//            // Disable animations
//            UIView.setAnimationsEnabled(false)
//            
//            // Preserve the current content offset
//            let originalOffset = replyTextView.contentOffset
//            
//            // Adjust the height constraint
//            replyTextView.constraints.forEach { (constraint) in
//                if constraint.firstAttribute == .height {
//                    constraint.constant = estimatedSize.height
//                }
//            }
//            
//            // Set the content offset back to its original position
//            replyTextView.setContentOffset(originalOffset, animated: false)
//            
//            // Re-enable animations
//            UIView.setAnimationsEnabled(true)
//        }
//    }

    
    func updateTimeLabel(for storyIndex: Int) {
        guard let mediaArray = contactStoriesData?.media, storyIndex < mediaArray.count else {
            timeLbl.text = ""
            return
        }

        let media = mediaArray[storyIndex]
        if let date = media.date, let time = media.time, let formattedTime = Converter.convertApiDateTime(apiDate: date, apiTime: time) {
            timeLbl.text = formattedTime
        } else {
            timeLbl.text = ""
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let storyBar = getCurrentStory() {
            storyBar.startAnimation()
        }
    }

    @IBAction func moreOptionAction(_ sender: Any) {
    }
    
    @IBAction func cancelBtnTouched() {
        self.dismiss(animated: true)
        {
            self.showTabBar?()
        }
        
    }
}

// MARK:- Helper Methods
extension StoryViewController {
    
    func setupModel() {
        
        for collection in imageCollection {
            arrUser.append(StoryHandler(imgs: collection))
        }
        StoryHandler.userIndex = rowIndex
        if rowIndex == 0
        {
           seenStoryCount = 1
        }
        outerCollection.reloadData()
        outerCollection.scrollToItem(at: IndexPath(item: StoryHandler.userIndex, section: 0),
                                     at: .centeredHorizontally, animated: false)
    }
    
    func currentStoryIndexChanged(index: Int) {
        
        arrUser[StoryHandler.userIndex].storyIndex = index
        updateTimeLabel(for: index)
        if index > 0
        {
            
            seenStoryCount = index + 1
        }
        
        if let textBackground = contactStoriesData?.media?[index].textBackground,
           let color = UIColor(hex: textBackground) {
            textStoryView.isHidden = false
            textStoryView.backgroundColor = color
        } else {
            textStoryView.isHidden = true
        }
        
        if let textData = contactStoriesData?.media?[index].text {
            textDataShowLbl.isHidden = false
            textDataShowLbl.text = textData
        } else {
            textDataShowLbl.isHidden = true
        }
    }


    
    func showNextUserStory() {
        let newUserIndex = StoryHandler.userIndex + 1
        if newUserIndex < arrUser.count {
            StoryHandler.userIndex = newUserIndex
            showUpcomingUserStory()
        } else {
            cancelBtnTouched()
        }
    }
    
    func showPreviousUserStory() {
        let newIndex = StoryHandler.userIndex - 1
        if newIndex >= 0 {
            StoryHandler.userIndex = newIndex
            showUpcomingUserStory()
        } else {
            cancelBtnTouched()
        }
    }
    

    func showUpcomingUserStory() {
        removeGestures()
        let indexPath = IndexPath(item: StoryHandler.userIndex, section: 0)
        outerCollection.reloadItems(at: [indexPath])
        outerCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let storyBar = self.getCurrentStory() {
                storyBar.animate(animationIndex: self.arrUser[StoryHandler.userIndex].storyIndex)
                self.addGesture()
            }
        }
        
        if let textBackground = contactStoriesData?.media?[StoryHandler.userIndex].textBackground,
           let color = UIColor(hex: textBackground) {
            textStoryView.isHidden = false
            textStoryView.backgroundColor = color
        } else {
            textStoryView.isHidden = true
        }
        
        if let textData = contactStoriesData?.media?[StoryHandler.userIndex].text {
            textDataShowLbl.isHidden = false
            textDataShowLbl.text = textData
        } else {
            textDataShowLbl.isHidden = true
        }
    }

    
    func getCurrentStory() -> StoryBar? {
        if let cell = outerCollection.cellForItem(at: IndexPath(item: StoryHandler.userIndex, section: 0)) as? OuterCell {
            return cell.storyBar
        }
        return nil
    }
}

// MARK:- Gestures
extension StoryViewController {
    
    func addGesture() {
        tapGest = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGest)
        
        longPressGest = UILongPressGestureRecognizer(target: self,
                                                         action: #selector(panGestureRecognizerHandler))
        longPressGest.minimumPressDuration = 0.2
        self.view.addGestureRecognizer(longPressGest)
        
        panGest = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        self.view.addGestureRecognizer(panGest)
    }
    
    func removeGestures() {
        self.view.removeGestureRecognizer(tapGest)
        self.view.removeGestureRecognizer(longPressGest)
        self.view.removeGestureRecognizer(panGest)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchLocation: CGPoint = gesture.location(in: gesture.view)
        let maxLeftSide = ((view.bounds.maxX * 40) / 100)
        if let storyBar = getCurrentStory() {
            if touchLocation.x < maxLeftSide {
                storyBar.previous()
            } else {
                storyBar.next()
            }
        }
    }
    
    func hideItemsForHold() {
        cancelBtn.isHidden = true
        userImageView.isHidden = true
        nameLbl.isHidden = true
        timeLbl.isHidden = true
        btnMoreOption.isHidden = true
    }
    
    func showItemsForHold() {
        cancelBtn.isHidden = false
        userImageView.isHidden = false
        nameLbl.isHidden = false
        timeLbl.isHidden = false
        btnMoreOption.isHidden = false
    }
    
    @objc func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        guard let storyBar = getCurrentStory() else { return }

        let touchPoint = sender.location(in: self.view?.window)
        if sender.state == .began {
            storyBar.pause()
            pauseCurrentVideo()
            initialTouchPoint = touchPoint
            hideItemsForHold()
        } else if sender.state == .changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: max(0, touchPoint.y - initialTouchPoint.y),
                                         width: self.view.frame.size.width,
                                         height: self.view.frame.size.height)
            }
        } else if sender.state == .ended || sender.state == .cancelled {
            if touchPoint.y - initialTouchPoint.y > 200 {
                dismiss(animated: true, completion: nil)
                self.showTabBar?()
            } else {
                storyBar.resume()
                resumeCurrentVideo()
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
                showItemsForHold()
            }
        }
    }
    
    func pauseCurrentVideo() {
            if let cell = outerCollection.cellForItem(at: IndexPath(item: StoryHandler.userIndex, section: 0)) as? OuterCell {
                if let innerCell = cell.innerCollection.cellForItem(at: IndexPath(item: arrUser[StoryHandler.userIndex].storyIndex, section: 0)) as? InnerCell {
                    innerCell.pauseVideo()
                }
            }
        }
        
        func resumeCurrentVideo() {
            if let cell = outerCollection.cellForItem(at: IndexPath(item: StoryHandler.userIndex, section: 0)) as? OuterCell {
                if let innerCell = cell.innerCollection.cellForItem(at: IndexPath(item: arrUser[StoryHandler.userIndex].storyIndex, section: 0)) as? InnerCell {
                    innerCell.resumeVideo()
                }
            }
        }
    
    
}

// MARK:- Collection View Data Source and Delegate
extension StoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! OuterCell
        cell.weakParent = self
        cell.setStory(story: arrUser[indexPath.row])
        return cell
    }
}

// MARK:- Scroll View Delegate
extension StoryViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let storyBar = getCurrentStory() {
            storyBar.pause()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let lastIndex = StoryHandler.userIndex
        let pageWidth = outerCollection.frame.size.width
        let pageNo = Int(floor(((outerCollection.contentOffset.x + pageWidth / 2) / pageWidth)))

        if lastIndex != pageNo {
            StoryHandler.userIndex = pageNo
            updateTimeLabel(for: arrUser[StoryHandler.userIndex].storyIndex) // Update time label when user index changes
            showUpcomingUserStory()
        } else {
            if let storyBar = getCurrentStory() {
                self.addGesture()
                storyBar.resume()
            }
        }
    }
}

