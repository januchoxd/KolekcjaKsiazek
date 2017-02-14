//
//  KsiazkaViewController.swift
//  KolekcjaKsiazek
//
//  Created by janusz jas on 14.02.2017.
//  Copyright © 2017 Janusz Pietkun. All rights reserved.
//

import UIKit

class KsiazkaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var obrazek: UIImageView!
    @IBOutlet weak var nazwaKsiazki: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //nadpisujemy obrazek
        obrazek.image = image
        
        //aby po wybraniu ibrazka z camera roll zniknął widok camera roll
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dodajButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let ksiazka = Ksiazka(context: context)
        ksiazka.title = nazwaKsiazki.text
        ksiazka.image = UIImagePNGRepresentation(obrazek.image!) as NSData?
        
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func bibliotekaTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        
    }

   
}
