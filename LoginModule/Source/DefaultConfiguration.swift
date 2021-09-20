//
//  DefaultConfiguration.swift
//  LoginModule
//
//  Created by Keerthi on 21/08/21.
//

import UIKit

public struct DefaultConfiguration {
    public var lineColor: UIColor
    public var selectedLineColor: UIColor
    public var textColor: UIColor
    public var placeholderColor: UIColor
    public var selectedTitleColor: UIColor
    public var selectedLineHeight: CGFloat
    public var placeholderFont: UIFont
    public var titleFont: UIFont
    
    public init(lineColor: UIColor = UIColor().colorFromHex(hex: "#9f9f9f"),
                selectedLineColor: UIColor = UIColor().colorFromHex(hex: "#EFB239"),
                textColor: UIColor = UIColor.black,
                placeholderColor: UIColor = UIColor().colorFromHex(hex: "#9f9f9f"),
                selectedTitleColor: UIColor = UIColor().colorFromHex(hex: "#EFB239"),
                selectedLineHeight: CGFloat = 1.0,
                placeholderFont: UIFont = UIFont.systemFont(ofSize: 13),
                titleFont: UIFont = UIFont.systemFont(ofSize: 13)) {
        self.lineColor = lineColor
        self.selectedLineColor = selectedLineColor
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.selectedTitleColor = selectedTitleColor
        self.selectedLineHeight = selectedLineHeight
        self.placeholderFont = placeholderFont
        self.titleFont = titleFont
    }
}
