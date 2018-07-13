//
//  BrowserviewController.swift
//  Neuron
//
//  Created by XiaoLu on 2018/7/13.
//  Copyright © 2018年 cryptape. All rights reserved.
//

import UIKit
import WebKit

class BrowserviewController: BaseViewController,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIScrollViewDelegate {
    
    var closeBtn:UIButton = UIButton()
    
    var requestUrlStr = ""{
        didSet{
            
        }
    }
    
    lazy private var webview: WKWebView = {
        self.webview = WKWebView.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH - 64))
        self.webview.navigationDelegate = self
        return self.webview
    }()
    
    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 2))
        self.progressView.tintColor = ColorFromString(hex: themeColor)      // 进度条颜色
        self.progressView.trackTintColor = UIColor.white // 进度条背景色
        return self.progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackButton()
        view.addSubview(webview)
        view.addSubview(progressView)
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        let url = URL(string:getRequestStr(requestStr: requestUrlStr))
        let request = URLRequest.init(url: url!)
        webview.load(request)
    }
    
    func setUpBackButton() {
        
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage.init(named: "nav_back"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10)
        backButton.addTarget(self, action: #selector(didClickBackButton), for: .touchUpInside)
        let bBarbutton = UIBarButtonItem.init(customView: backButton)
        
        closeBtn = UIButton.init(type: .custom)
        closeBtn.setImage(UIImage.init(named: "closeWebView"), for: .normal)
        closeBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        closeBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 20)
        closeBtn.isHidden = true
        closeBtn.addTarget(self, action: #selector(didClickCloseButton), for: .touchUpInside)
        let cBarbutton = UIBarButtonItem.init(customView: closeBtn)

        navigationItem.leftBarButtonItems = [bBarbutton,cBarbutton]
        
    }
    
    func getRequestStr(requestStr:String) -> String {
        if requestUrlStr.hasPrefix("http") {
            return requestStr
        }else{
            return "https://" + requestStr
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webview.estimatedProgress), animated: true)
            if webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        if webView.canGoBack {
            closeBtn.isHidden = false
        }else{
            closeBtn.isHidden = true
        }
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
    @objc func didClickBackButton(sender:UIButton){
        if webview.canGoBack {
            webview.goBack()
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didClickCloseButton(sender:UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}