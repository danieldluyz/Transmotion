//
//  MenuController.swift
//  TransMotion
//
//  Created by Daniel D'luyz O on 11/04/15.
//  Copyright (c) 2015 com.transmotion. All rights reserved.
//

import Foundation
import UIKit

class MenuController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var labelOrigen: UITextField!
    @IBOutlet weak var labelDestino: UITextField!
    
    @IBOutlet weak var picker: UIPickerView! = UIPickerView()
    @IBOutlet weak var pickerDestination: UIPickerView! = UIPickerView()
    @IBOutlet weak var button: UIButton!
    
    var latitude: Double?
    var longitude: Double?
    
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
        labelOrigen.delegate = self
        labelDestino.delegate = self
        
        picker.delegate = self
        picker.dataSource = self
        picker.hidden = true
        
        pickerDestination.delegate = self
        pickerDestination.dataSource = self
        pickerDestination.hidden = true
        
        labelOrigen.text = estaciones[0]
        labelDestino.text = estaciones[0]
        
        button.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buscarRuta(sender: AnyObject) {
        performSegueWithIdentifier("Routes", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Routes"{
            
            let routesController = segue.destinationViewController as! RoutesController
            
            let dictionary = NSDictionary(objects: [labelOrigen.text, labelDestino.text, latitude!, longitude!], forKeys: ["nombreEstacionOrigen", "nombreEstacionDestino", "latitud", "longitud"])
            
            println(dictionary)
            
            if NSJSONSerialization.isValidJSONObject(dictionary) {
                var err: NSError?
                
                let dataObject: NSData = NSJSONSerialization.dataWithJSONObject(dictionary, options: nil, error: &err)!
                
                let baseURL = NSURL(string: "https://calm-bayou-1093.herokuapp.com/costos")
                
                let request = NSMutableURLRequest(URL: baseURL!)
                request.HTTPMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.HTTPBody = dataObject
                
                var response: NSURLResponse?
                
                var tiempo: String = ""
                var congestion: String = ""
                
                
                var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    println("error \(httpResponse.statusCode)")
                    
                    println(httpResponse)
                    
                    let responseArray: NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray
                    
                    println("********")
                    println(responseArray)
                    
                    tiempo = responseArray[1].description
                    congestion = responseArray[0].description
                    
                }
                
                routesController.origen = labelOrigen.text
                routesController.destino = labelDestino.text
                routesController.tiempoMinimo = tiempo
                routesController.congestionMinima = congestion
                
            }

        }
        
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
        if(pickerView.tag==1){
            self.labelOrigen.text = self.estaciones[row];
        }
        else if(pickerView.tag==2){
            self.labelDestino.text = self.estaciones[row];
        }
        
        if (labelOrigen.text != estaciones[0] && labelDestino.text != estaciones[0])
        {
            
            picker.hidden = true
            pickerDestination.hidden = true
            button.hidden = false
        }
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        button.hidden = true
        
        if(textField.tag == 1){
            
            if pickerDestination.hidden == false {
                pickerDestination.hidden = true
            }
            picker.hidden = false
            
            return false
        }
        else if(textField.tag == 2){
            
            if picker.hidden == false {
                picker.hidden = true
            }
            
            pickerDestination.hidden = false
            return false
        }
        return false
    }
    

    
}
