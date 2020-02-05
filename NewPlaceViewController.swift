//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Дмитрий Чепанов on 04.02.2020.
//  Copyright © 2020 Дмитрий Чепанов. All rights reserved.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        //zamenyaem razlinovku nizhe kontenta na view
    
    }
//metod table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //esli vibrana 1 yacheyka
        if indexPath.row == 0 {
            //opredelyaem alert controller i deystviya
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                //metod vizova cameri
                self.chooseImagePicker(source: .camera)
            }
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                //photo
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            //dobavlyaem deystviya v alert
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet,animated: true)
        } else {
            //v protivnom skuchae skrit klavu
            view.endEditing(true)
        }
    }

}

extension NewPlaceViewController: UITextFieldDelegate {
    //skritie klaviaturi pri nazhatii done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//rashirenie dlya raboti s izobrazheniyami
extension NewPlaceViewController {
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        //proverka na dostupnost istochnika
        if UIImagePickerController.isSourceTypeAvailable(source){
            //sozdaem exzemplyar klassa
            let imagePicker = UIImagePickerController()
            //teper rabotaem s exz klassa, razreshaem redactirovat pered primeneniem
            imagePicker.allowsEditing = true
            //opredelyaem tip istochnika
            imagePicker.sourceType = source
            //vizov
            present(imagePicker, animated: true)
        }
    }
}
