//
//  ViewController.swift
//  browser-uiwebview
//
//  Created by FunatoShuhei on 2019/07/31.
//  Copyright © 2019 fspm. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    final let UI = "UI"
    final let WK = "WK"
    
    let uiwebview = UIWebView(frame: CGRect.zero)
    let wkwebview = WKWebView();
    
    let addressBar = UIView(frame: CGRect.zero)
    let switchwv = UIButton(frame: CGRect.zero)
    let input = UITextField(frame: CGRect.zero)
    let go = UIButton(frame: CGRect.zero)
    
    var isNowUIWebview: Bool {
        return (switchwv.titleLabel?.text == UI)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // addressbar
        view.addSubview(addressBar)
        addressBar.translatesAutoresizingMaskIntoConstraints = false
        addressBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        addressBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addressBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        addressBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        addressBar.backgroundColor = UIColor.red
        
        // go button
        addressBar.addSubview(go)
        go.translatesAutoresizingMaskIntoConstraints = false
        go.topAnchor.constraint(equalTo: addressBar.topAnchor).isActive = true
        go.bottomAnchor.constraint(equalTo: addressBar.bottomAnchor).isActive = true
        go.rightAnchor.constraint(equalTo: addressBar.rightAnchor).isActive = true
        go.widthAnchor.constraint(equalToConstant: 60).isActive = true
        go.backgroundColor = UIColor.blue
        go.setTitle("Go", for: .normal)
        go.addTarget(self, action: #selector(didTapGo), for: .touchUpInside)
        
        // switch button
        addressBar.addSubview(switchwv)
        switchwv.translatesAutoresizingMaskIntoConstraints = false
        switchwv.topAnchor.constraint(equalTo: addressBar.topAnchor).isActive = true
        switchwv.bottomAnchor.constraint(equalTo: addressBar.bottomAnchor).isActive = true
        switchwv.leftAnchor.constraint(equalTo: addressBar.leftAnchor).isActive = true
        switchwv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        switchwv.backgroundColor = UIColor.blue
        switchwv.setTitle(UI, for: .normal)
        switchwv.addTarget(self, action: #selector(didTapSwitchWV), for: .touchUpInside)
        
        // input
        addressBar.addSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.topAnchor.constraint(equalTo: addressBar.topAnchor).isActive = true
        input.bottomAnchor.constraint(equalTo: addressBar.bottomAnchor).isActive = true
        input.leftAnchor.constraint(equalTo: switchwv.rightAnchor).isActive = true
        input.rightAnchor.constraint(equalTo: go.leftAnchor).isActive = true
        input.backgroundColor = UIColor.clear
        input.autocapitalizationType = .none
        input.placeholder = "Input URL"
        input.delegate = self
        
        // uiwebview
        view.addSubview(uiwebview)
        uiwebview.translatesAutoresizingMaskIntoConstraints = false
        uiwebview.topAnchor.constraint(equalTo: addressBar.bottomAnchor).isActive = true
        uiwebview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        uiwebview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        uiwebview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        uiwebview.backgroundColor = UIColor.yellow
        
        // wkwebview
        view.addSubview(wkwebview)
        wkwebview.translatesAutoresizingMaskIntoConstraints = false
        wkwebview.topAnchor.constraint(equalTo: addressBar.bottomAnchor).isActive = true
        wkwebview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        wkwebview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        wkwebview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        wkwebview.backgroundColor = UIColor.green
        wkwebview.isHidden = true
        
    }
    
    // MARK: - Button actions
    
    @objc func didTapGo(sender: Any) {
        guard let urlText = input.text, let url = URL(string: urlText) else {
            return
        }
        let req = URLRequest(url: url)
        
        if isNowUIWebview {
            uiwebview.loadRequest(req)
        } else {
            wkwebview.load(req)
        }
    }
    
    @objc func didTapSwitchWV(sender: Any) {
        if isNowUIWebview {
            // UI -> WK
            switchwv.setTitle(WK, for: .normal)
            uiwebview.isHidden = true
            wkwebview.isHidden = false
            
        } else {
            // UI -> WK
            switchwv.setTitle(UI, for: .normal)
            uiwebview.isHidden = false
            wkwebview.isHidden = true
        }
    }
    
    
    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapGo(sender: go);
        return true
    }
}
