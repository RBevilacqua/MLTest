//
//  InstallmentViewController.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/17/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit
import Kingfisher

class InstallmentViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    var viewModel: InstallmentViewModel = InstallmentViewModel()
    
    var issuerCard: IssuerCard?
    var payment: PaymentMethods?
    var amount: Float?
    
    weak var delegate: InstallmentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configTitle(name: "Seleccione Cuotas")
        
        self.registerTableViewCells(nibName: "InstallmentTableViewCell", cellIdentifier: "InstallmentTableViewCell")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
        if let title = payment?.name {
            
            self.titleLabel.text = title
            
            if let image = payment?.secureThumbnail {
                self.cardImageView.kf.indicatorType = .activity
                self.cardImageView.kf.indicator!.startAnimatingView()
                self.cardImageView.kf.setImage(with: URL(string: image) as Resource?,
                                               placeholder: UIImage(named: ""),
                                               options: [.transition(ImageTransition.fade(1))],
                                               progressBlock: { receivedSize, totalSize in
                                                print("\(receivedSize)/\(totalSize)")
                },
                                               completionHandler: { image, error, cacheType, imageURL in
                                                print("Finished")
                                                self.cardImageView.kf.indicator!.stopAnimatingView()
                })
                
            } else {
                self.cardImageView.image = UIImage(named: "")
            }
            
        }
        
        if let idIssuer = issuerCard?.id, let idPayment = payment?.id {
            loading = Loading()
            loading?.show()
            viewModel.getInstallment(paymentId: idPayment, issuerId: idIssuer, amount: amount!) { (data, response, error) in
                DispatchQueue.main.async { [weak self] in
                    self?.loading?.dismiss()
                    
                    if error != nil {
                        // Message y Regresar
                        Message.show(text: "Ha ocurrido un error. Intentalo más tarde", type: .warning)
                        self?.navigationController?.popViewController(animated: true)
                        
                    } else {
                        self?.tableView.reloadData()
                        
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

extension InstallmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let installment = viewModel.installment.first, let quota = installment.payerCosts {
            return quota.count
        
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstallmentTableViewCell", for: indexPath) as! InstallmentTableViewCell
        if let installment = viewModel.installment.first, let quota = installment.payerCosts {
            cell.configIssuerCell(data: quota[indexPath.row])
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        Message.show(text: "Su seleccion se ha realizado exitosamente.", type: .success)
        if let installment = viewModel.installment.first, let quota = installment.payerCosts {
            self.delegate?.retrievePayCost(payer: quota[indexPath.row])
            
        }
        
        
    }
    
    
}
