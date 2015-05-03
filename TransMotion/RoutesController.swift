//
//  RoutesController.swift
//  TransMotion
//
//  Created by Daniel D'luyz O on 12/04/15.
//  Copyright (c) 2015 com.transmotion. All rights reserved.
//

import Foundation
import UIKit

class RoutesController: UIViewController {
    
    var tiempoMinimo: String?
    var congestionMinima: String?
    var origen: String?
    var destino: String?
    var latitude: Double?
    var longitude: Double?
    
    var titulo: String = "Tiempo"
    
    var baseURL = NSURL(string: "https://calm-bayou-1093.herokuapp.com/costos")
    
    @IBOutlet weak var labelOrigen: UILabel!
    @IBOutlet weak var labelDestino: UILabel!
    
    @IBOutlet weak var botonRutaTiempo: UIButton!
    @IBOutlet weak var botonRutaCongestion: UIButton!
    
    @IBOutlet weak var imageHolderTiempo: UIImageView!
    @IBOutlet weak var imageHolderCongestion: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if origen != nil && destino != nil && tiempoMinimo != nil && congestionMinima != nil
        {
            labelOrigen.text = "Dede: \(origen!)"
            labelDestino.text = "Hasta: \(destino!)"
            
            botonRutaTiempo.setTitle("Tiempo - \(tiempoMinimo!) minutos", forState: UIControlState.Normal)
            botonRutaCongestion.setTitle("Congestión - \(congestionMinima!)%", forState: UIControlState.Normal)
            
            imageHolderTiempo.image = UIImage(named: "green-circle-md")
            imageHolderCongestion.image = UIImage(named: "yellow-circle")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buscarRutaTiempo(sender: AnyObject) {
        
        titulo = "La ruta con el menor tiempo"
        baseURL = NSURL(string: "https://calm-bayou-1093.herokuapp.com/ruta/tiempo")
        performSegueWithIdentifier("Route", sender: sender)
        
    }
    
    
    @IBAction func buscarRutaCongestion(sender: AnyObject) {
        
        titulo = "La ruta con la menor congestión"
        baseURL = NSURL(string: "https://calm-bayou-1093.herokuapp.com/ruta/congestion")
        performSegueWithIdentifier("Route", sender: sender)
 
    }
  
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Route"{
            
            let routeController = segue.destinationViewController as! RouteController
            
            let dictionary = NSDictionary(objects: [origen!, destino!, "0.0", "0.0"], forKeys: ["nombreEstacionOrigen", "nombreEstacionDestino", "latitud", "longitud"])
            
            println(dictionary)
            
            if NSJSONSerialization.isValidJSONObject(dictionary) {
                var err: NSError?
                
                let dataObject: NSData = NSJSONSerialization.dataWithJSONObject(dictionary, options: nil, error: &err)!
                
                let request = NSMutableURLRequest(URL: baseURL!)
                request.HTTPMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.HTTPBody = dataObject
                
                var response: NSURLResponse?
                
                var array: Array<String> = []
                
                
                var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    println("error \(httpResponse.statusCode)")
                    
                    println(httpResponse)
                    
                    let responseArray: NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray
                    
                    println("********")
                    println(responseArray)
                    
                    for var i = 0; i < responseArray.count; i++
                    {
                        array.append(responseArray[i].description)
                    }
                
                }
                
                routeController.titulo = titulo
                routeController.ruta = array
                
                println("----------------")
                println(array)
            }
            
        }
        
    }
    
    
    
    
    
    
}
