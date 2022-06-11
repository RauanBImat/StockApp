//
//  ChartMarker.swift
//  StockApp
//
//  Created by Рауан Абишев on 10.06.2022.
//

import UIKit
import Charts


final class ChartMarker: MarkerView {
    private var text = String()
    private var radius: CGFloat = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let drawAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.semiBold(size: 16),
        .foregroundColor: UIColor.black,
        .backgroundColor: UIColor.systemBackground
    ]

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        text = "$\(entry.y)"
    }

    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)
        
        let circleRect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
        context.setFillColor(UIColor.black.cgColor)
        context.fillEllipse(in: circleRect)
        
        let sizeForDrawing = text.size(withAttributes: drawAttributes)
        bounds.size = sizeForDrawing
        offset = CGPoint(x: -sizeForDrawing.width / 2, y: -sizeForDrawing.height - 4)

        let offset = offsetForDrawing(atPoint: point)
        let originPoint = CGPoint(x: point.x + offset.x, y: point.y + offset.y)
        let rectForText = CGRect(origin: originPoint, size: sizeForDrawing)
        drawText(text: text, rect: rectForText, withAttributes: drawAttributes)
    }

    private func drawText(text: String, rect: CGRect, withAttributes attributes: [NSAttributedString.Key: Any]? = nil) {
        let size = bounds.size
        let centeredRect = CGRect(
            x: rect.origin.x + (rect.size.width - size.width) / 2,
            y: rect.origin.y + (rect.size.height - size.height) / 2 - 10,
            width: size.width,
            height: size.height
        )
        text.draw(in: centeredRect, withAttributes: attributes)
    }
}
