//
//  AddExpenseViewController.swift
//  Xpense
//
//  Created by Surjit on 26/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit
import Toast_Swift

class AddExpenseViewController: UIViewController {

    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    
    let datePicker = DatePicker()
    let viewModel = TransactionViewModel()
    
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
        self.categoryCollectionView.contentInset = UIEdgeInsets(top: 5, left: 30, bottom: 0, right: 30)
        
        self.categoryCollectionView.reloadData()
        self.initialState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.categoryCollectionView.reloadData()
    }
    
    func initialState() {
        self.resetCategory()
        self.viewModel.currentTransaction.date = Date().getCompleteDate()
        self.dateTextField.text = Date().formatDisplayDate()
        self.amountTextField.text = ""
        self.nameTextField.text = ""
    }
    
    fileprivate func makeToast(with message: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.backgroundColor = #colorLiteral(red: 0.3699039817, green: 0.7330554724, blue: 0.9979006648, alpha: 1)
        style.fadeDuration = 0.5
        self.view.makeToast(message, duration: 3.0, position: .top, style: style)
        ToastManager.shared.isTapToDismissEnabled = true
    }
    
    private func validedInputs() -> Bool {
        if let name = self.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), name.isEmpty, let amount = self.amountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), amount.isEmpty {
            self.makeToast(with: "Enter All Inputs")
            return false
        }
        if viewModel.selectedCategory == nil {
            makeToast(with: "Please Select Category")
            return false
        }
        return true
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if validedInputs() {
            self.viewModel.currentTransaction.amount = amountTextField.text
            self.viewModel.currentTransaction.currency = "USD"
            self.viewModel.currentTransaction.name = self.nameTextField.text
            self.viewModel.currentTransaction.id = UUID().uuidString
            self.viewModel.currentTransaction.category = self.viewModel.selectedCategory?.rawValue
            self.viewModel.currentTransaction.date = self.viewModel.currentTransaction.date
            self.viewModel.addtransaction { [weak self] success in
                self?.initialState()
                var message = "Expense could not be added"
                if success {
                    message = "Expense successfully added"
                }
                self?.makeToast(with: message)
            }
        }
        
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        self.initialState()
    }
}

extension AddExpenseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryType.getCategoryCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { preconditionFailure("Failed to load \(CategoryCollectionViewCell.identifier)")}
        
        let category = CategoryType.getCategory(for: indexPath.item)
        categoryCell.configureCell(for: category)
        
        return categoryCell
    }
}

extension AddExpenseViewController: UICollectionViewDelegate {
    fileprivate func resetCategory() {
        if let index = self.viewModel.selectedCategory?.getIndex() {
            let selectedIndexPath = IndexPath(item: index, section: .zero)
            if let categoryCell = self.categoryCollectionView.cellForItem(at: selectedIndexPath) {
                UIView.animate(withDuration: 0.4) {
                    categoryCell.transform = .identity
                    self.viewModel.selectedCategory = nil
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resetCategory()
        guard let categoryCell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { preconditionFailure("Failed to load \(CategoryCollectionViewCell.identifier)")}
        categoryCell.addCardPressAnimation {  [weak self] success in
        guard let self = self else { return }
            UIView.animate(withDuration: 0.2) {
                categoryCell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.viewModel.selectedCategory = CategoryType.getCategory(for: indexPath.item)
//                collectionView.reloadData()
                
            }
        }
    }

}
extension AddExpenseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = (collectionView.bounds.width - 2 * 30) / 3
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
            self.viewModel.currentTransaction.date = date.getCompleteDate()
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
