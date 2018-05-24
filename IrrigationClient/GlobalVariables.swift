//
//  GlobalVariables.swift
//  IrrigationClient
//
//  Created by Antonchikov Alexander on 23/05/2018.
//  Copyright © 2018 Antonchikov Alexander. All rights reserved.
//

import Foundation

class GlobalVariables {
    
    init() {
        // self.base_url = "http://192.168.1.72:5000/" // DO NOT FORGET TRAILING SLASH
        self.base_url = "http://raspberrypi.local:5000/"
        self.access_token = ""
    }
    
    // These are the properties you can store in your singleton
    private var base_url: String!
    
    private var access_token: String!
    
    //private var token: String {
    //    set { self.token = newValue }
    //    get { return self.token }
    //}

    
    
    func setAccessToken( access_token: String) {
        self.access_token = access_token
    }
    
    func  getAccessToken( ) -> String {
        return self.access_token
    }
    
    func setBaseUrl( base_url: String) {
        self.base_url = base_url
    }

    func  getBaseUrl( ) -> String {
        return self.base_url
    }
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
            
        }
        return Static.instance
    }
}
