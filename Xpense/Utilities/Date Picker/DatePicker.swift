//
//  DatePicker.swift
//  Xpense
//
//  Created by Surjit on 02/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit

class DatePicker : UIPickerView{
    var dateCollection = [Date]()
    
    func selectedDate()->Int{
        dateCollection = buildDateCollection()
        var row = 0
        for index in dateCollection.indices{
            let today = Date()
            if Calendar.current.compare(today, to: dateCollection[index], toGranularity: .day) == .orderedSame{
                row = index
            }
        }
        return row
    }
    
    func buildDateCollection()-> [Date]{
        dateCollection.append(contentsOf: Date.previousYear())
        dateCollection.append(contentsOf: Date.nextYear())
        return dateCollection
    }
}

// MARK - UIPickerViewDelegate
extension DatePicker : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let date = self.dateCollection[row]
        NotificationCenter.default.post(name: .dateChanged, object: nil, userInfo:["date": date])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}

// MARK - UIPickerViewDataSource
extension DatePicker : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateCollection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let label = dateCollection[row].formatDisplayDate()
        return label
    }
}
