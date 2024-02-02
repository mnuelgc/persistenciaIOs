//
//  Nota+Custom.swift
//  NotasCoreData
//
//  Created by Raquel Guerrero Perucho on 1/2/24.
//

import Foundation

extension Nota {
    @objc var inicial : String? {
        if let textoNonil = self.texto {
            return String (textoNonil.first!)
        }
        else{
            return nil
        }
    }
}
