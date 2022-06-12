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
    private var model: DetailModel?
    
    private lazy var chartsView: LineChartView = {
        let view = LineChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.xAxis.drawGridLinesEnabled = false
        view.xAxis.enabled = false
        view.xAxis.drawLabelsEnabled = false
        view.leftAxis.enabled = false
        view.leftAxis.drawGridLinesEnabled = false
        view.rightAxis.enabled = false
        view.rightAxis.drawGridLinesEnabled = false
        view.legend.setCustom(entries: [])
        view.backgroundColor = .systemBackground
        view.doubleTapToZoomEnabled = false
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
        setupMarker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with isLoading: Bool){
        isLoading ? loader.startAnimating() : loader.startAnimating()
        loader.isHidden = !isLoading
        buttonStackView.isHidden = isLoading
    }
    
    func configure(with model: DetailModel) {
        self.model = model
        addButtons(for: model.periods.map {$0.name})
        setCharts(with: model.periods.first?.prices)
        periodButtonTapped(sender: buttonStackView.subviews.first as? UIButton ?? UIButton())
    }
    
    private func setupSubview() {
        addSubview(chartsView)
        addSubview(buttonStackView)
        chartsView.addSubview(loader)
        
        NSLayoutConstraint.activate([
            chartsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chartsView.topAnchor.constraint(equalTo: topAnchor),
            chartsView.heightAnchor.constraint(equalTo: chartsView.widthAnchor,multiplier: 26/36),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            buttonStackView.topAnchor.constraint(equalTo: chartsView.bottomAnchor,constant: 40),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loader.centerXAnchor.constraint(equalTo: chartsView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: chartsView.centerYAnchor)
        ])
    }
    
    private func setupMarker() {
        let marker = ChartMarker()
        chartsView.marker = marker
        marker.chartView = chartsView
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
        
        guard let model = model else { return }
        let period = model.periods[sender.tag]
        setCharts(with: period.prices)
    }
    
    private func setCharts(with prices: [Double]?) {
        guard let prices = prices else {
            return
        }
        
        var yValues = [ChartDataEntry]()
        for (index, value) in prices.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index + 1), y: value)
            yValues.append(dataEntry)
        }
    
        let lineDataSet = lineCharDataSet(with: yValues)
        let data = LineChartData(dataSets: [lineDataSet])
        data.setDrawValues(false)
        
        chartsView.data = data
        chartsView.animate(xAxisDuration: 1)
    }
    
    private func lineCharDataSet(with entries: [ChartDataEntry]) -> LineChartDataSet {
        let lineDataSet = LineChartDataSet(entries: entries, label: nil)
        let gradientColors = [UIColor.chartBottomColor.cgColor,
                              UIColor.chartTopColor.cgColor] as CFArray
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB() ,
                                       colors: gradientColors,
                                       locations: colorLocations)
        
        lineDataSet.drawCirclesEnabled = false
        lineDataSet.valueFont = .boldSystemFont(ofSize: 10)
        lineDataSet.valueTextColor = .white
        lineDataSet.drawFilledEnabled = true
        lineDataSet.circleRadius = 3.0
        lineDataSet.circleHoleRadius = 2.0
        lineDataSet.mode = .cubicBezier
        lineDataSet.lineWidth = 2
        lineDataSet.setColor(.black)
        lineDataSet.drawHorizontalHighlightIndicatorEnabled = false
        lineDataSet.drawVerticalHighlightIndicatorEnabled = false
        lineDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        lineDataSet.drawFilledEnabled = true
        return lineDataSet
    }
    

    
}
