//
//  LoginViewController.swift
//  IrrigationClient
//
//  Created by Antonchikov Alexander on 23/05/2018.
//  Copyright © 2018 Antonchikov Alexander. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("Hello")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClick(_ sender: Any) {
        
        
        let parameters: [String: String] = [
            "username" : self.username.text!,
            "password" : self.password.text!,
            ]
        
        let url = GlobalVariables.sharedManager.getBaseUrl()+"auth"
        
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON {
                [weak self] response in
                
                guard let strongSelf = self else { return }
                
                guard response.result.isSuccess,
                    let dictionaryArray = response.result.value as? [String: String] else {
                        
                        let alert = UIAlertController(title: "Alert", message: "Ошибка", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        strongSelf.present(alert, animated: true, completion: nil)
                        return
                }
                GlobalVariables.sharedManager.setAccessToken(access_token: dictionaryArray["access_token"]!)
                
                strongSelf.performSegue(withIdentifier: "home", sender: strongSelf)
                //print(dictionaryArray)
        }
        
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
