//
//  CustomSwitch.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/24/23.
//  https://factoryhr.medium.com/making-custom-uiswitch-part-1-cc3ab9c0b05b
//  https://github.com/factoryhr/CustomUISwitch/blob/CustomSwitch/Sources/CustomUISwitch/CustomUISwitch/CustomSwitch.swift

import UIKit

public class CustomSwitch: UIControl {
    
    // MARK: Public properties
    
    public var isOn:Bool = true
    
    public var labelOff = UILabel()
    public var labelOn = UILabel()

    private var animationDelay: Double = 0
    private var animationSpriteWithDamping = CGFloat(0.7)
    private var initialSpringVelocity = CGFloat(0.5)
    private var animationDuration: Double = 0.5
    
    private let onColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
    private let offColor = UIColor(red: 0.153, green: 0.153, blue: 0.133, alpha: 1)
    
    private var onTintColor: UIColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
    private var offTintColor: UIColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
    
    // thumb properties
    private var thumbTintColor: UIColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
    
    private var thumbSize: CGSize = CGSize.zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    private var thumbView = UIView(frame: CGRect.zero)
    private var onPoint = CGPoint.zero
    private var offPoint = CGPoint.zero
    private var isAnimating = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
}

// MARK: Private methods
extension CustomSwitch {
    fileprivate func setupUI() {
        // clear self before configuration
        self.clear()
        
        self.clipsToBounds = false
        
        // configure thumb view
        self.thumbView.backgroundColor = self.thumbTintColor
        self.thumbView.isUserInteractionEnabled = false
        
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        self.addSubview(self.thumbView)
        self.setupLabels()
    }
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        self.animate()
        return true
    }
    
    
    func setOn(on: Bool, animated: Bool) {
        
        switch animated {
        case true:
            self.animate(on: on)
        case false:
            self.isOn = on
            self.setupViewsOnAction()
            self.completeAction()
        }
    }
    
    fileprivate func animate(on: Bool? = nil) {
        
        self.isOn = on ?? !self.isOn
        
        UIView.animate(
            withDuration: self.animationDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction],
            animations: {
                self.setupViewsOnAction()
            }, completion: { _ in
                self.completeAction()
            }
        )
    }
    
    private func setupViewsOnAction() {
        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        labelOn.textColor = self.isOn ? self.onColor : self.offColor
        labelOff.textColor = self.isOn ? self.offColor : self.onColor
    }

    private func completeAction() {
        self.isAnimating = false
        self.sendActions(for: UIControl.Event.valueChanged)
    }
}


// Mark: Public methods
extension CustomSwitch {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isAnimating {
            
            self.layer.cornerRadius = 5
            
            // thumb managment
            let thumbSize = CGSize(
                width: self.bounds.size.width / 2,
                height: self.bounds.height)
            
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width, y: yPostition)
            self.offPoint = CGPoint(x: 0, y: yPostition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = 5
            
            //label frame
            let labelWidth = self.bounds.width / 2
            self.labelOff.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
            self.labelOn.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
        }
    }
}


//Mark: Labels frame
extension CustomSwitch {
    
    fileprivate func setupLabels() {
        
        // не срабатывает, если ппри старте передаётся isOn = false
//        if isOn {
//            labelOff.textColor = offColor
//            labelOn.textColor = onColor
//        } else {
//            labelOff.textColor = onColor
//            labelOn.textColor = offColor
//        }
        
        labelOn.textColor = self.isOn ? self.onColor : self.offColor
        labelOff.textColor = self.isOn ? self.offColor : self.onColor

        labelOff.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        labelOn.font = UIFont(name: "Rubik-Light_Regular", size: 16)

        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.95
        labelOff.attributedText = NSMutableAttributedString(
            string: "Off", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        labelOn.attributedText = NSMutableAttributedString(
            string: "On", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        self.labelOff.textAlignment = .center
        self.labelOn.textAlignment = .center
        
        self.insertSubview(self.labelOff, aboveSubview: self.thumbView)
        self.insertSubview(self.labelOn, aboveSubview: self.thumbView)
    }
}
