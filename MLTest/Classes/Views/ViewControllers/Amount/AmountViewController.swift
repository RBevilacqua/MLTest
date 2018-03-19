//
//  AmountViewController.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/14/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

class AmountViewController: BaseViewController {

    @IBOutlet weak var amountTextField: UITextField!
    
    var amount: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureScreen()
        amountTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureScreen() -> Void {
        self.amountTextField.underlined()
    }
    
    @IBAction func payAction(_ sender: UIButton) {
        
        self.amountTextField.resignFirstResponder()
        if let amount = Float(amountTextField.text!) {
            self.amount = amount
            let vc = PaymentMethodsViewController(nibName: "PaymentMethodsViewController", bundle: nil)
            vc.amount = self.amount
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else {
            self.amountTextField.shake()
        }
    }
    
    func validate(value: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = value.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return (value == numberFiltered)
        

    }

}

extension AmountViewController: PaymentDelegate {
    
    func retrievePayment(retrieve: (issuer: IssuerCard, payer: PayerCost, payment: PaymentMethods)) {
        guard let amountViewController = navigationController?.viewControllers.first(where: { $0 is AmountViewController }) else {
            // Podrias hacer un fallback a rootViewController en caso de que no encuentre el AmountViewControler en el stack de navigation
            
            navigationController?.popToRootViewController(animated: true)
            return
        }
        navigationController?.popToViewController(amountViewController, animated: true)
        
        DispatchQueue.main.async {
            let alert = MLAlertView()
            alert.setData(payment: retrieve.payment, issuer: retrieve.issuer, payer: retrieve.payer, amount: self.amount!)
            alert.show()
            self.amount = nil
            self.amountTextField.text = ""
            
        }
        
    }
}

extension AmountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.validate(value: string)
    }
    
}
