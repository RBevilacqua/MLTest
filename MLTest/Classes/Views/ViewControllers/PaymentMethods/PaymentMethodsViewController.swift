//
//  PaymentMethodsViewController.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/15/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit
import Kingfisher

class PaymentMethodsViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var gridLayout: GridLayout = GridLayout(numberOfColumns: 2)
    
    var isGrid = true
    
    var viewModel: PaymentMethodsViewModel = PaymentMethodsViewModel()
    
    public var amount: Float?
    
    var paymentSelected: PaymentMethods?
    
    weak var delegate: PaymentDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configTitle(name: "Seleccione Metodo de Pago")
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "listIcon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.changeLayout))
        
        navigationItem.rightBarButtonItem = rightBarButton
        
        self.collectionView.collectionViewLayout = self.gridLayout
        
        loading = Loading()
        loading?.show()
        viewModel.getPaymentMethods { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                self?.loading?.dismiss()
                
                if error != nil {
                    // Message y Regresar
                    Message.show(text: "Ha ocurrido un error. Intentalo más tarde", type: .warning)
                    self?.navigationController?.popViewController(animated: true)
                    
                } else {
                    self?.collectionView.reloadData()
                    
                    
                }
                
                
                
            }
            
        }
        
        self.registerCollectionCells(nibName: "PaymentCardCollectionViewCell", cellIdentifier: "PaymentCardCollectionViewCell")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerCollectionCells(nibName: String, cellIdentifier: String) -> Void {
        let listNib = UINib(nibName: nibName, bundle: nil)
        self.collectionView.register(listNib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    @objc func changeLayout() -> Void {
        if isGrid != true {
            self.isGrid = true
            UIView.animate(withDuration: 0.2, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.gridLayout = GridLayout(numberOfColumns: 2)
                
                let rightBarButton = UIBarButtonItem(image: UIImage(named: "listIcon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.changeLayout))
                self.navigationItem.rightBarButtonItem = rightBarButton
                
                
                self.collectionView.setCollectionViewLayout(self.gridLayout, animated: true)
            }, completion: { (status) in
                for index in self.collectionView.indexPathsForVisibleItems {
                    let cell = self.collectionView.cellForItem(at: index) as! PaymentCardCollectionViewCell
                    cell.stackView.axis = .vertical
                }
            })
            
        } else {
            self.isGrid = false
            UIView.animate(withDuration: 0.2, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.gridLayout = GridLayout(numberOfColumns: 1)
                
                let rightBarButton = UIBarButtonItem(image: UIImage(named: "gridIcon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.changeLayout))
                self.navigationItem.rightBarButtonItem = rightBarButton
                
                self.collectionView.setCollectionViewLayout(self.gridLayout, animated: true)
            }, completion: { (status) in
                for index in self.collectionView.indexPathsForVisibleItems {
                    let cell = self.collectionView.cellForItem(at: index) as! PaymentCardCollectionViewCell
                    cell.stackView.axis = .horizontal
                }
                
            })
            
        }
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        self.changeLayout()
    }

}

extension PaymentMethodsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.paymentMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentCardCollectionViewCell", for: indexPath) as! PaymentCardCollectionViewCell
        if isGrid != true {
            cell.stackView.axis = .horizontal
        } else {
            cell.stackView.axis = .vertical
        }
        
        cell.setupView(data: viewModel.paymentMethods[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.viewModel.paymentMethods[indexPath.row].minAllowedAmount! < amount! {
            if self.viewModel.paymentMethods[indexPath.row].maxAllowedAmount! >= amount! {
                let vc = IssuerViewController(nibName: "IssuerViewController", bundle: nil)
                self.paymentSelected = self.viewModel.paymentMethods[indexPath.row]
                vc.amount = self.amount
                vc.payment = self.paymentSelected
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
            } else {
                Message.show(text: "Este monto supera el monto max de su tarjeta de credito.", type: .warning)
                print("Este monto supera el monto max de su tarjeta de credito.")
            }
        } else {
            Message.show(text: "Monto por debajo de lo permito para esta tarjeta.", type: .warning)
            print("Monto por debajo de lo permito.")
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        gridLayout.invalidateLayout()
    }
    
    
    
    
}

extension PaymentMethodsViewController: IssuerDelegate {
    
    func retrieveIssuer(retrieve: (issuer: IssuerCard, payer: PayerCost)) {
        self.delegate?.retrievePayment(retrieve: (issuer: retrieve.issuer, payer: retrieve.payer, payment: self.paymentSelected!))
        
    }
    
    
}
