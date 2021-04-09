//
//  SignInViewController.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func signInButton(_ sender: UIButton) {
        executeSignIn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func executeSignIn(){
        let parameters: [String: String] = [
            "email": nameInput.text ?? "",
            "password": passwordInput.text ?? ""
        ]
        
        AlamoService().signApi(url:.SIGN_IN, parameters: parameters, completion: { (response) in
            print("RESPOSTA \(response.token)")
        }, onApiError: {(response: SignErrorMessageModel) in
            print(response.message)
        }, onError: {(response) in
            
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
