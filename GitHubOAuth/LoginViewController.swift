//
//  LoginViewController.swift
//  GitHubOAuth
//
//  Created by Joel Bell on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Locksmith
import SafariServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageBackgroundView: UIView!
    
    var safariViewController: SFSafariViewController!
    
    let numberOfOctocatImages = 10
    var octocatImages: [UIImage] = []
    
    // MARK: - Functions
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let url = NSURL(string: GitHubAPIClient.URLRouter.oauth)
        safariViewController = SFSafariViewController(URL: url!)
        
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    func safariLogin(notification: NSNotification) {
        let url = notification.object as! String
        print(url)
        
        safariViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageViewAnimation()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(safariLogin), name: Notification.closeSafariVC, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if imageBackgroundView.layer.cornerRadius == 0 {
            configureButton()
        }
    }
}

// MARK: Setup View

extension LoginViewController {
    
    private func configureButton() {
        self.imageBackgroundView.layer.cornerRadius = 0.5 * self.imageBackgroundView.bounds.size.width
        self.imageBackgroundView.clipsToBounds = true
    }
    
    private func setUpImageViewAnimation() {
        for index in 1...numberOfOctocatImages {
            if let image = UIImage(named: "octocat-\(index)") {
                octocatImages.append(image)
            }
        }
        
        self.loginImageView.animationImages = octocatImages
        self.loginImageView.animationDuration = 2.0
        self.loginImageView.startAnimating()
    }
}