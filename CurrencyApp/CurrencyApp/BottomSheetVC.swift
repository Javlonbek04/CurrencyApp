//
//  BottomSheetVC.swift
//  CurrencyApp
//
//  Created by Abdulvoxid on 15/12/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    let titleLabel = UILabel()
    var bottomSheetTitle: String?
    var firstTFLabel = UILabel()
    var firsTFLabelText: String?
    var firstTF = UITextField()
    var secondTF = UITextField()
    var secondTFAmount: String?
    var calculateBtn = UIButton(type: .system)
    var data: [CurrencyData] = []
    var selectedCell: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitle()
        setupfirstTFLabel()
        setupFirstTF()
        setupSecondTF()
        setupCalculateBtn()
    }
}

extension BottomSheetViewController {
    func setupTitle() {
        titleLabel.text = bottomSheetTitle ?? "Default Title"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 40)
        view.addSubview(titleLabel)
    }
    
    func setupfirstTFLabel() {
        view.addSubview(firstTFLabel)
        firstTFLabel.text = firsTFLabelText
        firstTFLabel.translatesAutoresizingMaskIntoConstraints = false
        firstTFLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        firstTFLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
    }
    
    func setupFirstTF() {
        view.addSubview(firstTF)
        firstTF.translatesAutoresizingMaskIntoConstraints = false
        firstTF.topAnchor.constraint(equalTo: firstTFLabel.bottomAnchor, constant: 10).isActive = true
        firstTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        firstTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        firstTF.heightAnchor.constraint(equalToConstant: 56).isActive = true
        firstTF.layer.borderWidth = 1
        firstTF.layer.cornerRadius = 16
        firstTF.placeholder = "Qiymatni kiriting"
        let leftView = UILabel()
        leftView.text = "   "
        firstTF.leftView = leftView
        firstTF.leftViewMode = .always
    }
    
    func setupSecondTF() {
        view.addSubview(secondTF)
        secondTF.translatesAutoresizingMaskIntoConstraints = false
        secondTF.topAnchor.constraint(equalTo: firstTF.bottomAnchor, constant: 20).isActive = true
        secondTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        secondTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        secondTF.heightAnchor.constraint(equalToConstant: 56).isActive = true
        secondTF.layer.borderWidth = 1
        secondTF.layer.cornerRadius = 16
        secondTF.text = "0 UZS"
        let leftView = UILabel()
        leftView.text = "   "
        secondTF.leftView = leftView
        secondTF.leftViewMode = .always
        secondTF.isUserInteractionEnabled = false
    }
    
    func setupCalculateBtn() {
        view.addSubview(calculateBtn)
        calculateBtn.translatesAutoresizingMaskIntoConstraints = false
        calculateBtn.topAnchor.constraint(equalTo: secondTF.bottomAnchor, constant: 30).isActive = true
        calculateBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        calculateBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        calculateBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        calculateBtn.layer.cornerRadius = 16
        calculateBtn.layer.borderWidth = 1
        calculateBtn.setTitle("Calculate", for: .normal)
        calculateBtn.setTitleColor(UIColor.white, for: .normal)
        calculateBtn.backgroundColor = .black
        calculateBtn.addTarget(self, action: #selector(calculateBtnTapped), for: .touchUpInside)
        
    }
    
    @objc func calculateBtnTapped() {
        guard let selectedCell = selectedCell else {
                print("No cell selected")
                return
            }
        let currency = data[selectedCell]
    
        secondTF.text = "\(Double((Double(firstTF.text ?? "0") ?? 1.0) * (Double(currency.rate) ?? 1.0))) UZS"
    }
}

