//
//  OrdersTableViewController.swift
//  Orders
//
//  Created by Pedro Paramo on 1/29/20.
//  Copyright © 2020 Pedro Paramo. All rights reserved.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders() {
        guard let coffeOrdersURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL was incorrect")
        }
        
        let resource = Resource<[Order]>(url: coffeOrdersURL)
        
        Webservice().load(resource: resource) { result in
            switch result {
                case .success(let orders):
                    print(orders)
                    print("HOLA")
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}
