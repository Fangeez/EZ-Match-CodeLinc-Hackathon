//
//  ProfileViewController.swift
//  EZ Match
//
//  Created by Harris Dawurang on 4/3/22.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController {
    
    var editProfileView: EditProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileView = EditProfileView(frame: CGRect.zero)
        editProfileView.loginUser()
        editProfileView.configureData()
    
        self.view.addSubview(editProfileView)
        
    }
}
