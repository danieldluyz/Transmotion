//
//  RouteController.swift
//  TransMotion
//
//  Created by Daniel D'luyz O on 13/04/15.
//  Copyright (c) 2015 com.transmotion. All rights reserved.
//

import Foundation
import UIKit

class RouteController: UIViewController {
    
    var paradas: Array<String> = []
    
    var titulo: String?
    var ruta: Array<String> = []
    
    
    @IBOutlet weak var labelTitulo: UILabel!
    
    var labels: Array<UILabel> = []
    
    @IBOutlet weak var labelRecorrido1: UILabel!
    @IBOutlet weak var labelRecorrido2: UILabel!
    @IBOutlet weak var labelRecorrido3: UILabel!
    @IBOutlet weak var labelRecorrido4: UILabel!
    @IBOutlet weak var labelRecorrido5: UILabel!
    @IBOutlet weak var labelRecorrido6: UILabel!
    @IBOutlet weak var labelRecorrido7: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labels.append(labelRecorrido1)
        labels.append(labelRecorrido2)
        labels.append(labelRecorrido3)
        labels.append(labelRecorrido4)
        labels.append(labelRecorrido5)
        labels.append(labelRecorrido6)
        labels.append(labelRecorrido7)
        
        labelRecorrido1.hidden = true
        labelRecorrido2.hidden = true
        labelRecorrido3.hidden = true
        labelRecorrido4.hidden = true
        labelRecorrido5.hidden = true
        labelRecorrido6.hidden = true
        labelRecorrido7.hidden = true
        
        if titulo != nil {
            
            labelTitulo.text = titulo!
            
            if ruta.count > 0 {
                
                var recorrido: String = ruta[0]
                var linea = recorrido.componentsSeparatedByString("-")
                labelRecorrido1.text = "Diríjase a " + linea[0] + " y tome la ruta " + linea[1]
                labelRecorrido1.hidden = false
                
                var contador = 0;
                
                for var i = 1; i < ruta.count-1; i++ {
                    
                    println(ruta[i])
                    
                    var recorrido: String = ruta[i]
                    var linea = recorrido.componentsSeparatedByString("-")
                    var texto = "Descienda en " + linea[0] + " y tome la ruta " + linea[1]
                    
                    var label = labels[i]
                    label.hidden = false
                    label.text = texto
                    contador = i
                }

                contador = contador + 1;
                recorrido = ruta[contador]
                linea = recorrido.componentsSeparatedByString("-")
                labels[contador].hidden = false
                labels[contador].text = "Descienda en " + linea[0]
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}