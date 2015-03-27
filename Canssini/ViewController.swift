//
//  ViewController.swift
//  Canssini
//
//  Created by luojie on 3/27/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let ivc = segue.destinationViewController as? ImageViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "Earth":
                    ivc.imageURL = DemoURL.NASA.Earth
                case "Canssini":
                    ivc.imageURL = DemoURL.NASA.Cassini
                case "Saturn":
                    ivc.imageURL = DemoURL.NASA.Saturn
                default: break
                }
                ivc.title = identifier
            }
        }
        
    }
}

