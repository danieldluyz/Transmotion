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
                
                for var i = 0; i < ruta.count; i++ {
                    
                    println(ruta[i])
                    
                    var recorrido: String = ruta[i]
                    var linea = recorrido.componentsSeparatedByString("-")
                    var texto = "Tome la ruta " + linea[1] + " hasta " + linea[0]
                    
                    var label = labels[i]
                    label.hidden = false
                    label.text = texto
                    
                }

            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}