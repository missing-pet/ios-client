//
//  InspectAnnouncementPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 02.11.2020.
//

import UIKit
import Foundation
import Kingfisher

class InspectAnnouncementPresenter: PresenterType {
    
    var photoUrlSetter: UISetter<String>?
    var creationDateSetter: UISetter<String>?
    var animalTypeSetter: UISetter<String>?
    var descriptionSetter: UISetter<String>?
    var lostFoundSetter: UISetter<String>?
    var placeLabelSetter: UISetter<String?>?
    var usernameSetter: UISetter<String>?
    var callPhoneNumberSetter: UISetter<String>?
    var deleteAnnouncementButtonSetter: UISetter<Bool>?
    
    let announcement: Announcement
    
    let isMyAnnouncement: Bool
    
    private(set) var inspectAnnouncementDelegate: InspectAnnouncementDelegate?
    
    private(set) var announcementRepository: AnnouncementRepositoryType = AnnouncementMockRepository.instance
    
    init (announcement: Announcement, isMyAnnouncement: Bool = false, inspectAnnouncementDelegate: InspectAnnouncementDelegate? = nil) {
        self.announcement = announcement
        self.isMyAnnouncement = isMyAnnouncement
        self.inspectAnnouncementDelegate = inspectAnnouncementDelegate
    }
    
    func setup() {
        photoUrlSetter?(announcement.photo)
        creationDateSetter?(announcement.created_at)
        switch announcement.animal_type {
        case .dog:
            animalTypeSetter?("Собаки")
        case .cat:
            animalTypeSetter?("Кошки")
        case .other:
            animalTypeSetter?("Иное")
        }
        descriptionSetter?(announcement.description)
        switch announcement.announcement_type {
        case .lost:
            lostFoundSetter?("Место пропажи:")
        case .found:
            lostFoundSetter?("Место находки:")
        }
        placeLabelSetter?(announcement.place)
        usernameSetter?(announcement.user)
        callPhoneNumberSetter?(announcement.contact_phone_number)
        deleteAnnouncementButtonSetter?(!self.isMyAnnouncement)
    }
    
    func callPhoneNumber() {
        guard let telUrl = URL(string: "tel://\(announcement.contact_phone_number)") else { return }
        UIApplication.shared.open(telUrl, options: [:], completionHandler: nil)
    }
    
    func presentDeleteAnnouncementAlert(viewController: UIViewController) {
        let deleteAnnouncementAlert = UIAlertController(title: "Предупреждение", message: "Данное действие необратимо. Вы действительно хотите удалить это объявление?", preferredStyle: .alert)
        deleteAnnouncementAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        deleteAnnouncementAlert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in self.deleteAnnouncement(id: self.announcement.id) }))
        viewController.present(deleteAnnouncementAlert, animated: true, completion: nil)
    }
    
    private func deleteAnnouncement(id: Int) {
        announcementRepository.deleteAnnouncement(id: id)
        inspectAnnouncementDelegate?.updateTableView()
        Navigator(Storyboard.inspectAnnouncement).pop()
    }
    
    func presentImagePreviewViewController(viewController: UIViewController) {
        let vc = viewController as! InspectAnnouncementViewController
        guard let image = vc.announcementImageView.image else {
            return
        }
        Navigator(Storyboard.inspectAnnouncement).modal(ImagePreviewViewController.self, presenter: ImagePreviewPresenter(image: image))
    }
    
}
