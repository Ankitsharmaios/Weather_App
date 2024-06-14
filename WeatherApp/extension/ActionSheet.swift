//
//  ActionSheet.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 14/06/24.
//
import UIKit

class CustomAlertView: UIView {

    var options: [String]
    var optionSelected: ((String) -> Void)?

    init(options: [String]) {
        self.options = options
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 7

        var lastButton: UIButton? = nil

        for option in options {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.setTitleColor(appThemeColor.CommonBlack, for: .normal) // Set text color to black
            button.contentHorizontalAlignment = .left // Align text to the left
            button.titleLabel?.font = Helvetica.helvetica_regular.font(size: 15) // Set the button font
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(button)

            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), // Adjust leading anchor to create padding
                button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10), // Adjust trailing anchor to create padding
                button.heightAnchor.constraint(equalToConstant: 40)
            ])

            if let lastButton = lastButton {
                button.topAnchor.constraint(equalTo: lastButton.bottomAnchor).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            }

            lastButton = button
        }

        if let lastButton = lastButton {
            lastButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        }

        // Decrease width of the action sheet
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 170) // Adjust the width as needed
        ])
    }

    @objc private func optionTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        optionSelected?(title)
    }
}
