//
//  SignInViewController.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    private var indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    @IBAction func signInButton(_ sender: UIButton) {
        signIn()
    }
    
    private func signIn(){
        if ControllersUtils().checkFields(of: [emailInput, passwordInput]){
            executeSignInRequest()
        }
    }
    
    private func executeSignInRequest(){
        self.view.loaderElement(indicator: self.indicator, show: true)
        let parameters: [String: String] = [
            "email": emailInput.text ?? "",
            "password": passwordInput.text ?? ""
        ]
        
        AlamoService().signApi(url:.SIGN_IN, parameters: parameters, completion: { (response) in
            self.view.loaderElement(indicator: self.indicator, show: false)
            ControllersUtils().setToken(token: response.token)
            self.performSegue(withIdentifier: "loggedScreen", sender: nil)
        }, onApiError: {(response: SignErrorCodeModel) in
            self.view.loaderElement(indicator: self.indicator, show: false)
            var userMessage: String = ""
            
            switch response.code{
            case "INVALID_CREDENTIALS":
                userMessage = "Credenciais inválidas."
                break
            default:
                userMessage = "Erro Desconhecido."
            }
            
            self.alertModal(title: "Erro ao logar.", message: userMessage, onOk: {
                return
            })
        }, onError: {(response) in
            self.view.loaderElement(indicator: self.indicator, show: false)
            self.alertModal(title: "Erro!", message: "Houve um erro desconhecido, entre em contato com o suporte.", onOk: {
                return
            })
            print(response)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.cleanField()
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
