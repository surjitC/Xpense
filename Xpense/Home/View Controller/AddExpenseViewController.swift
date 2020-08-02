//
//  AddExpenseViewController.swift
//  Xpense
//
//  Created by Surjit on 26/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {

    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    
    let datePicker = DatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        amountTextField.delegate = self
        dateTextField.delegate = self
        datePicker.dataSource = datePicker
        datePicker.delegate = datePicker
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.categoryCollectionView.reloadData()
    }
}

extension AddExpenseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ExpenseCategory.shared.getCategoryCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { preconditionFailure("Failed to load \(CategoryCollectionViewCell.identifier)")}
        
        let category = ExpenseCategory.shared.getCategory(for: indexPath.item)
        categoryCell.configureCell(for: category)
        
        return categoryCell
    }

}

extension AddExpenseViewController: UICollectionViewDelegate {

}
extension AddExpenseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = collectionView.bounds.width / 3.5
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
}

extension AddExpenseViewController: UITextFieldDelegate{
    @objc
    func doneDatePicker(){
        dateTextField.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: .dateChanged, object: nil)
    }
    
    @objc
    func dateChanged(notification: Notification){
        let userInfo = notification.userInfo
        if let date = userInfo?["date"] as? Date {
            self.dateTextField.text = date.formatDisplayDate()
        }
    }
    
    fileprivate func setDatePicker(_ textField: UITextField) {
        datePicker.selectRow(datePicker.selectedDate(), inComponent: 0, animated: true)
        textField.inputView = datePicker
        let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: CGFloat(44))))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker))
        
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
        NotificationCenter.default.addObserver(self, selector: #selector(dateChanged(notification:)), name:.dateChanged, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateTextField {
            setDatePicker(textField)
        } else {
            textField.inputView = .none
        }
    }
}
