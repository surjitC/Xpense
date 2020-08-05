//
//  ChartsCollectionViewCell.swift
//  Xpense
//
//  Created by Surjit on 01/08/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit
import Charts
import Lottie

class ChartsCollectionViewCell: UICollectionViewCell {

    static let idenfier = "ChartsCollectionViewCell"
    
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet var mainBackgroundView: UIView!
        
    var animationView: AnimationView?
    var emptyView: UIView?
    let colorDict: [CategoryType: UIColor] = [.Food: UIColor.systemYellow, .Bills: UIColor.systemTeal, .Entertainment: UIColor.systemPurple, .Travel: UIColor.systemGreen, .Shopping: UIColor.systemOrange, .Miscellaneous: UIColor.systemPink]
    
    lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainBackgroundViewTapped))
        return tap
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.backgroundColor = .cyan
//        setUpPieChart()
        mainBackgroundView.addShadow()
        mainBackgroundView.isUserInteractionEnabled = true
        mainBackgroundView.addGestureRecognizer(tap)
    }
    
    private func showPieChartLoading() {
        self.removePieChartLoading()
        animationView = AnimationView()
        animationView?.animation = Animation.named(LottieEnum.PieChartLoading.rawValue)
        emptyView = UIView()
        emptyView?.frame = pieChartView.frame
        mainBackgroundView.addSubview(emptyView!)
        emptyView?.backgroundColor = mainBackgroundView.backgroundColor
        emptyView?.addSubview(animationView!)
        animationView?.frame = pieChartView.frame
        animationView?.center = emptyView!.center
        animationView?.loopMode = .loop
        animationView?.play()
    }
    
    private func removePieChartLoading() {
        self.animationView?.stop()
        self.animationView?.removeFromSuperview()
        self.emptyView?.removeFromSuperview()
    }
    
    func setUpPieChart(for transactions: [Transaction]) {
        if transactions.isEmpty {
            self.showPieChartLoading()
            return
        } else {
            self.removePieChartLoading()
        }
        var categoryDict: [CategoryType: [Transaction]] = [ : ]
        transactions.forEach { transaction in
            if let category = transaction.category, let categoryType = CategoryType(rawValue: category) {
                if categoryDict[categoryType] != nil {
                    categoryDict[categoryType]?.append(transaction)
                } else {
                    categoryDict[categoryType] = [transaction]
                }
            }
        }
        
        var colors: [UIColor] = []
        var dataEntries = [ChartDataEntry]()
        for (key, value) in categoryDict {
            colors.append(colorDict[key] ?? UIColor.systemPink)
            let count = Double(value.count)
            let entry = ChartDataEntry(x: count, y: count)
            dataEntries.append(entry)
        }
        let dataSet = PieChartDataSet(entries: dataEntries)
        dataSet.colors = colors
        dataSet.automaticallyDisableSliceSpacing = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        pieChartView.animate(xAxisDuration: 1, yAxisDuration: 1)
    }

    @objc
    func mainBackgroundViewTapped() {
        mainBackgroundView.addCardPressAnimation { [weak self] success in
            print(success)
        }
    }
}
