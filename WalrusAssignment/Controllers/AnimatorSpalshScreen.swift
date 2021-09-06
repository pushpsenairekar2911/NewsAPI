//
//  Animator.swift
//  WalrusAssignment
//
//  Created by Pushpsen Airekar on 06/09/21.
//

import Foundation
import UIKit


class AnimatorSpalshScreen: UIViewController {
    
    enum ViewSize {
    case collapsed
    case normal
    case expanded
        
        mutating func toggle() {
            switch self {
            case .collapsed: self = .normal
            case .normal: self = .expanded
            case .expanded: self = .expanded
            }
        }
    }
    
    @IBOutlet weak var animatorView: UIView!
    
    var viewModel: AnimatorSplashScreenViewModel!
    var size: ViewSize = .collapsed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.navigationController?.navigationBar.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        animatorView.addGestureRecognizer(tap)
        animatorView.isUserInteractionEnabled = true
    }
    
    private func animateView(forSize: ViewSize) {
        switch forSize {
        case .collapsed:
            let scaledTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                self?.animatorView.center = self?.view.center ?? CGPoint(x: 0, y: 0)
                self?.animatorView.transform = scaledTransform
                self?.animatorView.backgroundColor = UIColor(named: "view-color-2")
            })
        case .normal:
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                let scaledTransform = CGAffineTransform(scaleX: (self?.view.frame.size.width)!, y: (self?.view.frame.size.height)!)
                 self?.animatorView.transform = scaledTransform
                self?.animatorView.backgroundColor = UIColor(named: "view-color-3")
                
            })
        case .expanded:
            viewModel.didTapOnSkip()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.animateView(forSize: size)
        size.toggle()
    }
    
    @IBAction func didSkipPressed(_ sender: Any) {
        viewModel.didTapOnSkip()
    }
    
}
