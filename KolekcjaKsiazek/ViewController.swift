//
//  ViewController.swift
//  KolekcjaKsiazek
//
//  Created by janusz jas on 14.02.2017.
//  Copyright © 2017 Janusz Pietkun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var ksiazki : [Ksiazka] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            try ksiazki = context.fetch(Ksiazka.fetchRequest())
            tableView.reloadData()
        } catch{
            
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ksiazki.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let ksiazka = ksiazki[indexPath.row]
        cell.textLabel?.text = ksiazka.title
        cell.imageView?.image = UIImage(data: ksiazka.image as! Data)
        return cell
        
    }
    
}

