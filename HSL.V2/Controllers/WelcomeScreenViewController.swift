//
//  WelcomeScreenViewController.swift
//  HSL.V2
//
//  Created by Yana Krylova on 26.4.2023.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    private let welcomeScreenView: WelcomeScreenView
    // Create the welcome screen view
    let welcomeScreenModel = WelcomeScreenModel()

    // Add the welcome screen view as a subview of another view
    let containerView = UIView(frame: UIScreen.main.bounds)
    containerView.addSubview(welcomeScreenView.view)

    init(welcomeScreenModel: WelcomeScreenModel) {
        self.welcomeScreenView = WelcomeScreenView()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = WelcomeScreenView
    }
}

