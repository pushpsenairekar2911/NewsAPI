//
//  ViewController.swift
//  WalrusAssignment
//
//  Created by Pushpsen Airekar on 06/09/21.
//

import UIKit
import WebKit

class ShowArticle: UIViewController {

    var url : String?
    private let webView = WKWebView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupViews()
       loadRquest()
    }
    
    private func loadRquest() {
        self.view.setNeedsLayout()
        if let url = URL(string: url ?? "") {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }

    private func setupViews() {
        self.view.backgroundColor = UIColor(named: "theme-color")

        navigationItem.leftBarButtonItem =   UIBarButtonItem(image: UIImage(systemName: "xmark"), landscapeImagePhone: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(didTapOnClose))
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "bar-color")
        
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "ToucheW03-Bold", size: 20) ?? UIFont.systemFont(ofSize: 30, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "ToucheW03-Bold", size: 20) ?? UIFont.systemFont(ofSize: 15, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.standardAppearance = appearance
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor(named: "theme-color")
        self.view.addSubview(self.webView)
       
        NSLayoutConstraint.activate([
            self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
    }
    
    @objc func didTapOnClose() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

