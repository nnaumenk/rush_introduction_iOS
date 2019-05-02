//
//  ThirdViewController.swift
//  introductionIOS
//
//  Created by Nazar NAUMENKO on 4/24/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import UIKit

extension ThirdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = DataController.places
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell")! as UITableViewCell
        let array = DataController.places
        let element = array[indexPath.row]
        cell.textLabel?.text = element.title
        return cell
    }
}

extension ThirdViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataController.currentIndex = indexPath.row
        performSegue(withIdentifier: "segueToMap", sender: nil)
    }
}

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
