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
    
    @IBOutlet weak var libretaSelector: UIPickerView!
    
    
    
    @IBOutlet weak var userMessages: UILabel!
    
    let miGestorPicker = GestotPicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.libretaSelector.delegate = self.miGestorPicker
        self.libretaSelector.dataSource = self.miGestorPicker
        
        self.miGestorPicker.cargarLista()
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
        
        let numLibreta = self.libretaSelector.selectedRow(inComponent: 0)
        nuevaNota.libreta = miGestorPicker.libretas[numLibreta]
        
        do {
            try miContexto.save()
        } catch {
            print("Error al guardar el contexto : \(error)")
        }
        
        notaData.text = Date().description
        
        userMessages.text = "Nota guardada"
    }
    
    @IBAction func nuevaLibreta(_ sender: Any) {
        
        let alert = UIAlertController(title: "Nueva libreta",
                                      message : "Escribe el nombre para la nueva libreta",
                                      preferredStyle: .alert)
        let crear = UIAlertAction(title:"Crear", style: .default){
            action in
            let nombre = alert.textFields![0].text!
            
            guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
            }
            let miContexto = miDelegate.persistentContainer.viewContext
            
            let nuevaLibreta = Libreta(context:miContexto)
            nuevaLibreta.nombre = nombre
            
            self.miGestorPicker.libretas.append(nuevaLibreta)
            self.libretaSelector.reloadAllComponents()
            
            do {
                try miContexto.save()
            } catch {
                print("Error al guardar la libreta : \(error)")
            }
        }
        let cancelar = UIAlertAction(title:"Cancelar", style: .cancel){
            action in
        }
        
        alert.addAction(crear)
        alert.addAction(cancelar)
        alert.addTextField() {$0.placeholder  = "Nombre"}
        self.present(alert, animated: true)
    }
    
    
}

