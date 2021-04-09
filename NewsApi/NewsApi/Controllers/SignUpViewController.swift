//
//  SignUpViewController.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    private var indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    @IBAction func submitButton(_ sender: UIButton) {
        signUp()
    }
    
    private func signUp(){
        if ControllersUtils().checkFields(of: [nameInput, emailInput, passwordInput, confirmPasswordInput]){
            if (passwordInput.text ?? "") == (confirmPasswordInput.text ?? ""){
                executeSignUpRequest()
            } else {
                self.alertModal(title: "Senhas diferentes.", message: "Verifique as senhas.", onOk: {
                    return
                })
            }
        }
    }
    
    private func executeSignUpRequest(){
        self.view.loaderElement(indicator: self.indicator, show: true)
        let parameters: [String: String] = [
            "name": nameInput.text ?? "",
            "email": emailInput.text ?? "",
            "password": passwordInput.text ?? ""
        ]
        
        AlamoService().signApi(url:.SIGN_UP, parameters: parameters, completion: { (response) in
            self.view.loaderElement(indicator: self.indicator, show: false)
            self.alertModal(title: "Usuário cadastrado!", message: "Faça login com suas credenciais.", onOk: {
                self.dismiss(animated: true, completion: nil)
                return
            })
            print("RESPOSTA \(response.token)")
        }, onApiError: {(response: SignErrorModel) in
            self.view.loaderElement(indicator: self.indicator, show: false)
            var userMessage: String = ""
            
            switch response.errors[0].code{
            case "TAKEN":
                userMessage = "Esse e-mail já foi cadastrado."
                break
            case "INVALID":
                userMessage = "Formato de e-mail inválido."
                break
            default:
                userMessage = "Erro Desconhecido."
            }
            
            self.alertModal(title: "Erro no e-mail.", message: userMessage, onOk: {
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
