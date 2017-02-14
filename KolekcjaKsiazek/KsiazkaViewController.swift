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
    @IBOutlet weak var dodajButtonOutlet: UIButton!
    
    var imagePicker = UIImagePickerController()
    var ksiazka : Ksiazka? = nil
    
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //tworzymy stała image która przekazuje nam który obrazek został wybrany przez użytkownika
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //nadpisujemy obrazek
        obrazek.image = image
        
        //aby po wybraniu ibrazka z camera roll zniknął widok camera roll
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //przycisk dodawania nowej ksiazki
    @IBAction func dodajButton(_ sender: Any) {
        if ksiazka != nil {
            ksiazka!.title = nazwaKsiazki.text
            ksiazka!.image = UIImagePNGRepresentation(obrazek.image!) as NSData?
            
        }else {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let ksiazka = Ksiazka(context: context)
        ksiazka.title = nazwaKsiazki.text
        ksiazka.image = UIImagePNGRepresentation(obrazek.image!) as NSData?
        }
        
        //zapisujemy do core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    //otwieranie zasobu zdjęc wymaga pozwolenia
    @IBAction func bibliotekaTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    // uzycie aparatu rowniez wymaga pozwolenia 
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
   //przycisk usuwania
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBAction func deleteButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //usuwamy ksiazke
        context.delete(ksiazka!)
        //zapisujemy do core data zmiane
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if ksiazka != nil {
            obrazek.image = UIImage(data: ksiazka?.image as! Data)
            nazwaKsiazki.text = ksiazka?.title
            dodajButtonOutlet.setTitle("update", for: .normal)
            
        } else {
        // w tym przypadku chowamy przycisk usuwania ( bo tu dodajemy nowa ksiazke)
         deleteButtonOutlet.isHidden = true
        }
        
        
    }

   
}
