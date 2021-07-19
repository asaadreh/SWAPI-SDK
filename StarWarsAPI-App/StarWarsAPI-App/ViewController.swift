//
//  ViewController.swift
//  StarWarsAPI-App
//
//  Created by Agha Saad Rehman on 16/07/2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let api = StarWarsAPI()
        
//        api.getOne(resource: "people", withId: 1, requiredAttributes: ["height","gender"]) { res in
//            switch res {
//            case .success(let attribute):
//                print(attribute)
//            case .failure(_):
//                print("Failed")
//            }
//        }
        
        api.getAll(resource: "films",
                   requiredAttribute: ["title","opening_crawl","release_date"]) { res in
            
                switch res {
                case .success(let attribute):
                    print(attribute)
                case .failure(_):
                    print("Failed")
                }
        }
    }
    
}

