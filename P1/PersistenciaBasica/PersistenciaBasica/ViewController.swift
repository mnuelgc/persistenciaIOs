//
//  ViewController.swift
//  PersistenciaBasica
//
//  Created by Raquel Guerrero Perucho on 25/1/24.
//

import UIKit

class ViewController: UIViewController {

    
    var fechaEdicion : Date = Date()
    
    @IBOutlet weak var TextViewField: UITextView!
    
    @IBOutlet weak var LabelField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let preferencias = UserDefaults()
        
        let text = preferencias.string(forKey: "texto")
        let fecha = preferencias.object(forKey: "fecha")
        
        TextViewField.text = text
        
        if let fechaCast = fecha as? Date{
            LabelField.text = fechaCast.description 
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: Any) {
        self.fechaEdicion = Date()
        
        self.LabelField.text = DateFormatter.localizedString(
            from: self.fechaEdicion,
            dateStyle: .short, timeStyle: .medium)
        
        let prefs = UserDefaults()
        prefs.set(TextViewField.text, forKey: "texto")
        prefs.set(self.fechaEdicion, forKey: "fecha")
        
        prefs.synchronize()

    }
    
}

