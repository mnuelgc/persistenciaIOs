//
//  ViewController.swift
//  NotasCoreData
//
//  Created by Raquel Guerrero Perucho on 26/1/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var notaText: UITextView!
    
    @IBOutlet weak var notaData: UILabel!
    
    
    @IBOutlet weak var userMessages: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func create(_ sender: Any) {
        notaText.text = "";
        notaData.text = "";
        userMessages.text = "";
    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let miContexto = miDelegate.persistentContainer.viewContext
            
        let nuevaNota = Nota(context:miContexto)
        nuevaNota.fecha = Date()
        nuevaNota.texto = notaText.text
        
        do {
            try miContexto.save()
        } catch {
            print("Error al guardar el contexto : \(error)")
        }
        
        notaData.text = Date().description
        
        userMessages.text = "Nota guardada"
    }
    
    
}

