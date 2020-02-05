//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Дмитрий Чепанов on 04.02.2020.
//  Copyright © 2020 Дмитрий Чепанов. All rights reserved.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    @IBOutlet weak var imageOfPlace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        //zamenyaem razlinovku nizhe kontenta na view
    
    }
//metod table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //esli vibrana 1 yacheyka
        if indexPath.row == 0 {
          
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            //opredelyaem alert controller i deystviya
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                //metod vizova cameri
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                //photo
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
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
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        //proverka na dostupnost istochnika
        if UIImagePickerController.isSourceTypeAvailable(source){
            //sozdaem exzemplyar klassa
            let imagePicker = UIImagePickerController()
            //назначаем сам класс исполнителем методоа (делегатом)
            imagePicker.delegate = self
            //teper rabotaem s exz klassa, razreshaem redactirovat pered primeneniem
            imagePicker.allowsEditing = true
            //opredelyaem tip istochnika
            imagePicker.sourceType = source
            //vizov
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOfPlace.image = info[.editedImage] as? UIImage
        //берем значение по ключу editedimage и присваиваем его как uiumage свойству imageofplace
        imageOfPlace.contentMode = .scaleAspectFill
        //позволяет масштабировать изображение по содержимого uiimage
        imageOfPlace.clipsToBounds = true
        //обрезка по границам uiimage
        dismiss(animated: true)
        //закрытие uiimage
        //теперь выше делегируем исполнение этого метода
    }
}
