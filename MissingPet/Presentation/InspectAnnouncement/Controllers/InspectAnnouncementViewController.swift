//
//  InspectAnnouncementViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 02.11.2020.
//

import UIKit

class InspectAnnouncementViewController: Controller<InspectAnnouncementPresenter> {

    @IBOutlet weak var announcementImageView: AnnouncementImageView!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var animalTypeLabel: UILabel!
    @IBOutlet weak var lostFoundLabel: UILabel!
    @IBOutlet weak var placeButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var callPhoneNumberButton: UIButton!
    @IBOutlet weak var deleteAnnouncementButton: UIButton!
    @IBOutlet weak var placeButtonWithImage: UIButton!
    
    override func viewDidLoad() {
        presenter?.photoUrlSetter = { [weak self] photoUrl in
            self?.announcementImageView.image = UIImage(named: photoUrl) //.kf.setImage(with: photoUrl)
        }
        presenter?.creationDateSetter = { [weak self] creationDate in
            self?.creationDateLabel.text = creationDate
        }
        presenter?.animalTypeSetter = { [weak self] animalType in
            self?.animalTypeLabel.text = animalType
        }
        presenter?.descriptionSetter = { [weak self] desc in
            self?.descriptionLabel.text = desc
        }
        presenter?.lostFoundSetter = { [weak self] lostFound in
            self?.lostFoundLabel.text = lostFound
        }
        presenter?.placeButtonSetter = { [weak self] place in
            self?.placeButton.setTitle(place, for: .normal)
        }
        presenter?.usernameSetter = { [weak self] username in
            self?.usernameLabel.text = username
        }
        presenter?.callPhoneNumberSetter = { [weak self] phoneNumber in
            self?.callPhoneNumberButton.setTitle(phoneNumber, for: .normal)
        }
        presenter?.deleteAnnouncementButtonSetter = { [weak self] isMyAnnouncement in
            self?.deleteAnnouncementButton.isHidden = isMyAnnouncement
        }
        presenter?.placeButtonBackgroundImageSetter = { [weak self] image in
            self?.placeButtonWithImage.setBackgroundImage(image, for: .normal)
        }
        super.viewDidLoad()
    }

    @IBAction func callPhoneNumber(_ sender: UIButton) {
        presenter?.callPhoneNumber()
    }
    
    
    @IBAction func deleteAnnouncement(_ sender: UIButton) {
        presenter?.presentDeleteAnnouncementAlert(viewController: self)
    }
}