//
//  ChartsCollectionViewCell.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit
import Charts

class ChartsCollectionViewCell: UICollectionViewCell {

    static let idenfier = "ChartsCollectionViewCell"
    
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet var mainBackgroundView: UIView!
        
    lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainBackgroundViewTapped))
        return tap
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.backgroundColor = .cyan
        setUpPieChart()
        mainBackgroundView.addShadow()
        mainBackgroundView.isUserInteractionEnabled = true
        mainBackgroundView.addGestureRecognizer(tap)
    }
    
    
    fileprivate func setUpPieChart() {
        var dataEntries = [ChartDataEntry]()
        for _ in 0...5 {
            let entry = ChartDataEntry(x: Double(10), y: Double(10))
            dataEntries.append(entry)
        }
        let dataSet = PieChartDataSet(entries: dataEntries)
        dataSet.colors = [UIColor.systemYellow, UIColor.systemTeal, UIColor.systemPurple, UIColor.systemGreen, UIColor.systemOrange, UIColor.systemPink]
        dataSet.automaticallyDisableSliceSpacing = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
    }

    @objc
    func mainBackgroundViewTapped() {
        mainBackgroundView.addCardPressAnimation { [weak self] success in
            print(success)
        }
    }
}
