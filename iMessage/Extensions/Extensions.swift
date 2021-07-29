//
//  Extensions.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit
import JGProgressHUD

// MARK: - Constraints

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    

}

extension UIViewController {
    
    // MARK: - Gradient animation
    
    func configureGradient() {

        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(named: "darkGreen")?.cgColor as Any, UIColor(named: "lightGreen")?.cgColor as Any]
        gradient.locations = [0, 0.5]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.1, 0.5]
        gradientAnimation.toValue = [0.1, 1]
        gradientAnimation.duration = 5.0
        gradientAnimation.autoreverses = true
        gradientAnimation.repeatCount = Float.infinity
        gradient.add(gradientAnimation, forKey: nil)

    }
    
    // MARK: - Button animation

    func buttonAnimation(_ animatedView: UIView) {
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            
            animatedView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        }) {(_) in
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
        
                animatedView.transform = CGAffineTransform(scaleX: 1, y: 1)
        
            }, completion: nil)
        }
    }
    
    // MARK: - Hud
    
    func showLoader(_ show: Bool, withText text: String? = "Loading") {
        
        view.endEditing(true)
        let hud = JGProgressHUD(style: .dark)
        
        hud.textLabel.text = text
        
        if show {
            
            hud.show(in: view)
            
        } else {
            
            hud.dismiss()
            
        }
        
    }
    
    // MARK: - Navi bar configuration
    
    func  configureNavBar(withTitle title: String, prefersLargeTitles: Bool) {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(named: "lightGreen")
        
        navigationController?.navigationBar.standardAppearance = appearance
        //navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationItem.title = title
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        
    }
    
    func showErrorMessages( _ errorMessage: String) {
        
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIAlertController {

  //Set background color of UIAlertController
  func setBackgroudColor(color: UIColor) {
    if let bgView = self.view.subviews.first,
      let groupView = bgView.subviews.first,
      let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }

  //Set title font and title color
  func setTitle(font: UIFont?, color: UIColor?) {
    guard let title = self.title else { return }
    let attributeString = NSMutableAttributedString(string: title)//1
    if let titleFont = font {
      attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
        range: NSMakeRange(0, title.utf8.count))
    }
    if let titleColor = color {
      attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
        range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributeString, forKey: "attributedTitle")//4
  }

  //Set message font and message color
  func setMessage(font: UIFont?, color: UIColor?) {
    guard let title = self.message else {
      return
    }
    let attributedString = NSMutableAttributedString(string: title)
    if let titleFont = font {
      attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.utf8.count))
    }
    if let titleColor = color {
      attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributedString, forKey: "attributedMessage")//4
  }

  //Set tint color of UIAlertController
  func setTint(color: UIColor) {
    self.view.tintColor = color
  }
}


