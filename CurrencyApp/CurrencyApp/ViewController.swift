//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Abdulvoxid on 14/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var data: [CurrencyData] = []
    private let animator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Valyutalar"
        view.backgroundColor = .red
        
        setUPTableView()
        loadData()
        
    }
    
    func setUPTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        view.addSubview(animator)
        animator.center = view.center
    }
    
    func loadData() {
        animator.startAnimating()
        NetworkManager.shared.getData { [weak self] fetchedData in
            guard let fetchedData = fetchedData else {
                print("Failed to fetch data or decode.")
                return
            }
            DispatchQueue.main.async {
                self?.data = fetchedData
                self?.tableView.reloadData()
                self?.animator.stopAnimating()
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let currency = data[indexPath.row]
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.forwardslash.minus"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = indexPath.row
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 60)
        cell.accessoryView = button
        
        let fullText =  "\(currency.ccyNmUZ)  \(currency.diff)"
        let attributedText = NSMutableAttributedString(string: fullText)
        let diffRange = (fullText as NSString).range(of: "\(currency.diff)")
        if currency.diff.starts(with: "-") {
            attributedText.addAttribute(.foregroundColor, value: UIColor.systemRed, range: diffRange)
        } else {
            attributedText.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: diffRange)
        }
        cell.textLabel?.attributedText = attributedText
        
        cell.detailTextLabel?.text = "\(currency.nominal) \(currency.ccy) = \(currency.rate) UZS | \(currency.date)"
        cell.detailTextLabel?.textColor = .gray
        
        return cell
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        let currency = data[index]
        
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        bottomSheetVC.bottomSheetTitle = currency.ccyNmUZ
        bottomSheetVC.firsTFLabelText = currency.ccy
        bottomSheetVC.selectedCell = index
        bottomSheetVC.data = data
        
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
}

