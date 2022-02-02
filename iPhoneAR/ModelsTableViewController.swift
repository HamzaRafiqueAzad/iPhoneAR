//
//  ModelsTableViewController.swift
//  IphoneAR
//
//  Created by Hamza Rafique Azad on 30/1/22.
//

import Foundation
import UIKit

class ModelsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let imageNames = ["Floating_Fox", "ANSALDO_A1_-_BALILLA", "Fortnite_The_MandalorianBaby_Yoda", "Minigun_animated", "Post_Apocalyptic_Phone_Booth", "Salomon_X_RAISE_Hiking", "Vintage_Telephone_-__Paramount_Classics"]
    
    var delegate : ViewController?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModelsTableViewCell", for: indexPath) as! ModelsTableViewCell
        
        let image = UIImage(named: imageNames[indexPath.row])
        
        cell.modelImage?.image = image?.withRenderingMode(.alwaysOriginal)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            self.delegate?.addModel(named: self.imageNames[indexPath.row])
            
        }
        
        dismiss(animated: true)
    }
    
}
