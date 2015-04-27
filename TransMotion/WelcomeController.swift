//
//  WelcomeController.swift
//  TransMotion
//
//  Created by Daniel D'luyz O on 26/04/15.
//  Copyright (c) 2015 com.transmotion. All rights reserved.
//

import Foundation
import UIKit

class WelcomeController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func planearRuta(sender: AnyObject) {
        performSegueWithIdentifier("buscarRuta", sender: sender)
    }
    
    @IBAction func congestionEstacion(sender: AnyObject) {
        performSegueWithIdentifier("congestionEstacion", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "buscarRuta"{
            let menuController = segue.destinationViewController as! MenuController
        }
        else if segue.identifier == "congestionEstacion" {
            let congestionController = segue.destinationViewController as! CongestionController
        }
    }
}
