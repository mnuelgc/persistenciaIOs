//
//  GestorPicker.swift
//  NotasCoreData
//
//  Created by Raquel Guerrero Perucho on 30/1/24.
//

import Foundation

import UIKit

import CoreData

class GestotPicker : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    var libretas = [Libreta]()
    
    // devuelve el número de columnas del picker. En nuestro caso solo 1
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // devuekve el número de filas del picker (== numero de libretas)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.libretas.count
    }
    
    // devuelve el título de una fila determinada
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.libretas[row].nombre
    }
    
    // para cargar la lista de libretas desde Core Data
    func cargarLista() {
        let miDelegate = UIApplication.shared.delegate as! AppDelegate
        let miContexto = miDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Libreta>(entityName: "Libreta")
        self.libretas = try! miContexto.fetch(request)
    }
}
