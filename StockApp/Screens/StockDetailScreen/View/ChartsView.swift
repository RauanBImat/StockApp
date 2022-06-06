//
//  ChartsView.swift
//  StockApp
//
//  Created by Рауан Абишев on 06.06.2022.
//

import Foundation
import UIKit
import Charts


final class ChartsContainerView: UIView {
    private lazy var chartsView: LineChartView  = {
        let view = LineChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
    
        view.xAxis.drawLabelsEnabled = false
        view.leftAxis.enabled = false
        view.leftAxis.drawGridLinesEnabled = false
        view.rightAxis.enabled = false
        view.rightAxis.enabled = false
        view.rightAxis.drawGridLinesEnabled = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with isLoading: Bool){
        isLoading ? loader.startAnimating() : loader.startAnimating()
        loader.isHidden = !isLoading
        buttonStackView.isHidden = isLoading
    }
    func configure(with model : ChartsModel){
    setCharts(with: [0,1,2,3,45,33,23,22])

    }
    
    private func setupSubview() {
        addSubview(chartsView)
        addSubview(buttonStackView)
        
        chartsView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        chartsView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        chartsView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        chartsView.heightAnchor.constraint(equalTo: chartsView.widthAnchor,multiplier: 26/36).isActive = true
        
        buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16).isActive = true
        buttonStackView.topAnchor.constraint(equalTo: chartsView.bottomAnchor,constant: 40).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        addButtons(for: ["W","M","6M","1Y"])
        
        chartsView.addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: chartsView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: chartsView.centerYAnchor).isActive = true
        
    }
    
    private func addButtons(for titles: [String]) {
        titles.enumerated().forEach { (index,title) in
            let button = UIButton()
            button.tag = index
            button.backgroundColor = .buttonColor
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .bold(size: 12)
            button.layer.cornerRadius = 12
            button.layer.cornerCurve = .continuous
            button.addTarget(self, action:#selector(periodButtonTapped), for: .touchUpInside)
            buttonStackView.addArrangedSubview(button)
            
            

        }
    }
    
    @objc private func periodButtonTapped(sender: UIButton){
        buttonStackView.subviews.compactMap { $0 as? UIButton }.forEach { button in
            button.backgroundColor = .buttonColor
            button.setTitleColor(.black, for: .normal)
        }
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
    }
    private func setCharts(with prices: [Double]) {
        var yValues = [ChartDataEntry]()
        for(index,value) in prices.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index + 1),y:value)
            yValues.append(dataEntry)
        }
        
        let lineDataSet = LineChartDataSet(entries: yValues,label: "$")
        lineDataSet.valueFont = .bold(size: 10)
        lineDataSet.valueTextColor = .black
        lineDataSet.fill = Fill(color: UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1))
        lineDataSet.drawFilledEnabled = true
        lineDataSet.highlightColor = .black
        lineDataSet.circleRadius = 3.0
        lineDataSet.circleHoleRadius = 2.0
        
        chartsView.data = LineChartData(dataSets: [lineDataSet])
        chartsView.animate(xAxisDuration: 0.3,yAxisDuration: 0.2)
        
        
     }
    
}
struct ChartsModel {}
