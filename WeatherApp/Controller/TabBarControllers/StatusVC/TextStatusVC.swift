//
//  TextStatusVC.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 04/06/24.
//

import UIKit
import AVFoundation

class TextStatusVC: UIViewController , UITextViewDelegate{

    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var btnChangeStatusShow: UIButton!
    @IBOutlet weak var btnMicAndSend: UIButton!
    @IBOutlet weak var lblStatuscontact: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var btnColureChange: UIButton!
    @IBOutlet weak var btnTextStyle: UIButton!
    @IBOutlet weak var btnSmiley: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var mainColureView: UIView!
    
    var callback:(() -> Void )?
    
    
    var showTabBar: (() -> Void)?
    let colorCodes = [
            "#ae8774", "#243640", "#f0b330", "#b6b327", "#c69fcc",
            "#8b6990", "#ff8a8c", "#54c265", "#ff7b6b", "#26c4dc",
            "#57c9ff", "#74676a", "#7e90a3", "#5696ff", "#6e257e",
            "#7acba5", "#243640", "#8294ca", "#a62c71", "#90a841"
        ]
   
    let fonts = [
            "Helvetica",
            "Arial",
            "Times New Roman",
            "Courier New",
            "Georgia",
            "Verdana",
            "Arial Rounded MT Bold"
        ]

        var currentFontIndex = 0
        var selectedColorCode: String?
    
    
    var colors: [UIColor] = []
    
    private let placeholderLabel: UILabel = {
            let label = UILabel()
             label.text = "Type a status"
             label.textColor = .lightText
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    class func GetInstance()-> TextStatusVC {
        return TextStatusVC.viewController(storyboard: Constants.Storyboard.DashBoard)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupPlaceholder()
        adjustTextViewInsets()
        colors = colorCodes.map { UIColor(hex: $0)! }
        changeautoColure()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            adjustTextViewInsets()
        }
    
    private func adjustTextViewInsets() {
            // Calculate the top inset to align the text with the placeholder's vertical position
            let topInset = statusTextView.bounds.height / 2 - placeholderLabel.intrinsicContentSize.height / 2
        statusTextView.textContainerInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            
            // Adjust text container line fragment padding to center text horizontally
        statusTextView.textContainer.lineFragmentPadding = 0
        statusTextView.textAlignment = .center
        }
    private func setupPlaceholder() {
        statusTextView.addSubview(placeholderLabel)
           
           // Center the placeholder label horizontally and vertically within the text view
           NSLayoutConstraint.activate([
               placeholderLabel.centerXAnchor.constraint(equalTo: statusTextView.centerXAnchor),
               placeholderLabel.centerYAnchor.constraint(equalTo: statusTextView.centerYAnchor),
               placeholderLabel.widthAnchor.constraint(equalTo: statusTextView.widthAnchor, multiplier: 0.8)
           ])
           
           // Initially show the placeholder
           placeholderLabel.isHidden = !statusTextView.text.isEmpty
       }
    
    func changeautoColure()
    {
               let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
               let selectedColor = colors[randomIndex]
               
               // Change the UIView's background color
               mainColureView.backgroundColor = selectedColor
               
               // Store the selected color code
               selectedColorCode = colorCodes[randomIndex]
               
               // For debugging: Print the selected color code
               print("Selected color code: \(selectedColorCode ?? "")")
        
    }
    
   func setUpUI()
    {
        statusTextView.delegate = self
        lblStatuscontact.font = Helvetica.helvetica_regular.font(size: 14)
        lblStatuscontact.textColor = appThemeColor.white
         
        statusTextView.font = Helvetica.helvetica_regular.font(size: 20)
      
        statusView.layer.cornerRadius = 15
       
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .lightText {
                textView.text = nil
                textView.textColor = .white
            }
           
        }
  
        func textViewDidChange(_ textView: UITextView) {
            // Check if the text view is empty and show the camera button accordingly
            if textView.text.isEmpty {
                btnMicAndSend.setImage(UIImage(named: "Mic"), for: .normal)
            
            } else {
                btnMicAndSend.setImage(UIImage(named: "Send"), for: .normal)
            
            }
            
            placeholderLabel.isHidden = !statusTextView.text.isEmpty
        }
   
    
    

    @IBAction func cancelAction(_ sender: Any) 
    {
        self.dismiss(animated: true)
        {
            self.showTabBar?()
        }
    }
    
    @IBAction func changeStatusShowAction(_ sender: Any) 
    {
        
    }
    @IBAction func micsendAction(_ sender: Any) 
    {
        addStory()
    }
    @IBAction func colureChangeAction(_ sender: UIButton)
    {
        
        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
               let selectedColor = colors[randomIndex]
               
               // Change the UIView's background color
               mainColureView.backgroundColor = selectedColor
               
               // Store the selected color code
               selectedColorCode = colorCodes[randomIndex]
               
               // For debugging: Print the selected color code
               print("Selected color code: \(selectedColorCode ?? "")")
        
    }
    @IBAction func textStyleAction(_ sender: Any)
    {
        currentFontIndex = (currentFontIndex + 1) % fonts.count
               print("Applying font: \(fonts[currentFontIndex])") // Log the font name
               if let font = UIFont(name: fonts[currentFontIndex], size: 20) {
                   statusTextView.font = font
               } else {
                   print("Error: Font not found: \(fonts[currentFontIndex])")
               }
        
        }
    
    @IBAction func smileyAction(_ sender: Any)
    {
        
    }
}
extension TextStatusVC
{
//    //MARK: Call Api
    func addStory(){
        let parameters: [String: String] = [
            "RegisterId": getString(key: userDefaultsKeys.RegisterId.rawValue),
            "StoryType": "text" ,
            "Text":statusTextView.text ?? "",
            "TextBackground":selectedColorCode ?? "",
            "Textstyle":"\(fonts[currentFontIndex])"
       ]
      
        
        DataManager.shared.addStory(params: parameters,isLoader: false, view: view) { [weak self] (result) in
            switch result {
            case .success(let addStory):
                print("addStory ", addStory)
                self?.dismiss(animated: true)
                {
                    self?.callback?()
                    self?.showTabBar?()
                }
                
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
                
            }
        }
    }
    
}


extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r, g, b, a: CGFloat
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
