//
//  IssuerViewController.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/17/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

class IssuerViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: IssuerViewModel = IssuerViewModel()
    
    var payment: PaymentMethods?
    var amount: Float?
    var issuerSelected: IssuerCard?
    
    weak var delegate: IssuerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configTitle(name: "Selecciona el Banco")
        
        self.registerTableViewCells(nibName: "IssuerTableViewCell", cellIdentifier: "IssuerTableViewCell")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
        if let id = payment?.id {
            loading = Loading()
            loading?.show()
            viewModel.getIssuers(paymentId: id) { [weak self] (data, response, error) in
                
                DispatchQueue.main.async {
                    self?.loading?.dismiss()
                    
                    if error != nil {
                        // Message y Regresar
                        Message.show(text: "Ha ocurrido un error. Intentalo más tarde", type: .warning)
                        self?.navigationController?.popViewController(animated: true)
                        
                    } else {
                        
                        if data!.count > 0 {
                            self?.tableView.reloadData()
                            
                        } else {
                            // Message y Regresar
                            Message.show(text: "No hay información sobre bancos para la tarjeta \(self?.payment?.name ?? "")", type: .warning)
                            self?.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                    
                    
                    
                }
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerTableViewCells(nibName: String, cellIdentifier: String) -> Void {
        let listNib = UINib(nibName: nibName, bundle: nil)
        self.tableView.register(listNib, forCellReuseIdentifier: cellIdentifier)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension IssuerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.issuers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssuerTableViewCell", for: indexPath) as! IssuerTableViewCell
        cell.configIssuerCell(data: viewModel.issuers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.issuerSelected = self.viewModel.issuers[indexPath.row]
        let vc = InstallmentViewController(nibName: "InstallmentViewController", bundle: nil)
        vc.amount = self.amount
        vc.payment = payment
        vc.issuerCard = self.issuerSelected
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension IssuerViewController: InstallmentDelegate {
    
    func retrievePayCost(payer: PayerCost) {
        self.delegate?.retrieveIssuer(retrieve: (issuer: self.issuerSelected!, payer: payer))
    }
    
}
