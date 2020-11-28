//
//  ProfileViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import UIKit

class ProfileViewController: Controller<ProfilePresenter> {
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
    }
    
    
    @IBAction func presentSignOutAlert(_ sender: UIButton) {
        presenter?.presentSignOutAlert(viewController: self)
    }
    
}
