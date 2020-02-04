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
