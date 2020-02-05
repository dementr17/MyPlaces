//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Дмитрий Чепанов on 04.02.2020.
//  Copyright © 2020 Дмитрий Чепанов. All rights reserved.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    var newPlace: Place?
    var imageIsChanged = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

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
    
    func saveNewPlace() {
        var image: UIImage?
        
        if imageIsChanged{
            image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        } 
        newPlace = Place(name: placeName.text!,
                         location: placeLocation.text,
                         type: placeType.text,
                         image: image,
                         restaurauntImage: nil)
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension NewPlaceViewController: UITextFieldDelegate {
    //skritie klaviaturi pri nazhatii done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
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
        placeImage.image = info[.editedImage] as? UIImage
        //берем значение по ключу editedimage и присваиваем его как uiumage свойству imageofplace
        placeImage.contentMode = .scaleAspectFill
        //позволяет масштабировать изображение по содержимого uiimage
        placeImage.clipsToBounds = true
        //обрезка по границам uiimage
        imageIsChanged = true
        dismiss(animated: true)
        //закрытие uiimage
        //теперь выше делегируем исполнение этого метода
    }
}
