//
//  ViewController.swift
//  SwiftChat
//
//  Created by Mikhail on 21.04.2021.
//

import UIKit

class StartViewController: UIViewController {
    
//    MARK: - Properties
    private var spinnerView: UIView?

//    MARK: - Outlets
    @IBOutlet weak var startImage: UIImageView! {
        didSet {
            startImage.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            startImage.layer.shadowOpacity = 0.5
            startImage.layer.shadowOffset = CGSize(width: 0, height: 5)
            startImage.layer.shadowRadius = 4
            startImage.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.layer.backgroundColor = #colorLiteral(red: 0.8117647059, green: 0.1215686275, blue: 0.1568627451, alpha: 1)
            startButton.layer.shadowColor = #colorLiteral(red: 0.8941176471, green: 0.1333333333, blue: 0.1764705882, alpha: 1)
            startButton.layer.shadowOpacity = 0.5
            startButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            startButton.layer.shadowRadius = 9
            startButton.setTitle("Enter", for: .normal)
            startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            startButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            startButton.layer.cornerRadius = startButton.frame.height / 2
            startButton.alpha = 0.0
        }
    }
    
//    MARK: - Life Cicle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButton()
    }
    
    // MARK: - IBActions
    @IBAction func startButtonTapped(_ sender: Any) {
        showSpinner()
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { (t) in
            self.removeSpinner()
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (t) in
            self.performSegue(withIdentifier: "chatsSegue", sender: nil)
            }
        }
    }
    
// MARK: - Private Functions
    private func updateButton() {
        startButton.center.y  -= view.bounds.height / 2
        startButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIButton.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut) {
            self.startButton.alpha = 1.0
            self.startButton.center.y += self.view.bounds.height / 2
            self.startButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    private func showSpinner() {
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = .white
        spinnerView?.alpha = 0.4
        spinnerView?.center.x += view.bounds.width
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .beginFromCurrentState) {
            self.spinnerView?.center.x -= self.view.bounds.width
        }
        
        let spinner = UIImageView(image: #imageLiteral(resourceName: "activityIndicator"))
        spinner.center = self.view.center
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = 3
        spinner.layer.add(rotationAnimation, forKey: nil)
        spinnerView?.addSubview(spinner)
        self.view.addSubview(spinnerView!)
    }
    
    private func removeSpinner() {
        spinnerView?.removeFromSuperview()
        spinnerView = nil
    }
}
