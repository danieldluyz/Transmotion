//
//  CongestionController.swift
//  TransMotion
//
//  Created by Daniel D'luyz O on 26/04/15.
//  Copyright (c) 2015 com.transmotion. All rights reserved.
//

import Foundation
import UIKit


class CongestionController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var estacionText: UITextField!
    
    @IBOutlet weak var labelCongestion: UILabel!
    
    @IBOutlet weak var pickerEstacion: UIPickerView!
    
    @IBOutlet weak var imagenCongestion: UIImageView!
    
    let estaciones = ["Seleccionar",
        "Universidades",
        "Calle26",
        "Av.39",
        "Calle57",
        "Polo",
        "EscuelaMilitar",
        "Av.68",
        "Granja.Cra77",
        "PortalDeLa80",
        "Universidades",
        "CentroMemoria",
        "PlazaDeLaDemocracia",
        "CiudadUniversitaria",
        "Corferias",
        "QuintaParedes",
        "Gobernacion",
        "CAN",
        "SalitreElGreco",
        "ElTiempoMaloka",
        "AvRojas",
        "Normandia",
        "Modelia",
        "PortalElDorado",
        "LasAguas",
        "MuseoDelOro",
        "AvJimenez",
        "Calle19",
        "Av.39",
        "Calle57",
        "Calle72",
        "Calle76",
        "Heroes",
        "Virrey",
        "Calle100",
        "PepeSierra",
        "Prado",
        "Calle142",
        "Toberin",
        "PortalNorte",
        "PortalElDorado",
        "Modelia",
        "Av.Rojas",
        "ElTiempoMaloka",
        "SalitreElGreco",
        "CAN",
        "Quintaparedes",
        "Corferias",
        "Av.Chile",
        "NQSCalle75",
        "PepeSierra",
        "Alcala",
        "Santafe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estacionText.delegate = self
        
        pickerEstacion.delegate = self
        pickerEstacion.dataSource = self
        pickerEstacion.hidden = true
        
        labelCongestion.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.estaciones.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return self.estaciones[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.estacionText.text = self.estaciones[row];
        
        if (estacionText.text != estaciones[0])
        {
            buscarCongestion()
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        pickerEstacion.hidden = false
        imagenCongestion.hidden = true
        labelCongestion.text = ""
        return false
    }
    
    func buscarCongestion() {
        
         pickerEstacion.hidden = true
        
        let dictionary = NSDictionary(objects: [estacionText.text], forKeys: ["nombreEstacion"])
            
        let baseURL = NSURL(string: "https://calm-bayou-1093.herokuapp.com/estacion/congestion")
        
        if NSJSONSerialization.isValidJSONObject(dictionary) {
            var err: NSError?
            
            let dataObject: NSData = NSJSONSerialization.dataWithJSONObject(dictionary, options: nil, error: &err)!
            
            let request = NSMutableURLRequest(URL: baseURL!)
            request.HTTPMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = dataObject
            
            var response: NSURLResponse?
            
            var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
            
            if let httpResponse = response as? NSHTTPURLResponse {
                println("Código \(httpResponse.statusCode)")
                
                let congestion: NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray
                
                var cong: Double = congestion[0] as! Double
                //var con = NSString(string: cong).doubleValue
                var con = cong/2
                
                labelCongestion.text = "La congestión en la estación es de \(con)%"
                
                if con < 50 {
                    imagenCongestion.image = UIImage(named: "green")
                    imagenCongestion.hidden = false
                }
                else if con < 75 {
                    imagenCongestion.image = UIImage(named: "yellow")
                    imagenCongestion.hidden = false
                }
                else {
                    imagenCongestion.image = UIImage(named: "red")
                    imagenCongestion.hidden = false
                }
                
            }
        }
    }
}