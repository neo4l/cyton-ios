//
//  QRCodeController.swift
//  Neuron
//
//  Created by XiaoLu on 2018/5/21.
//  Copyright © 2018年 cryptape. All rights reserved.
//

import UIKit


class QRCodeController: BaseViewController,HRQRCodeScanToolDelegate {
    func scanQRCodeFaild(error: HRQRCodeTooError) {
     print(error)
    }
    
    func scanQRCodeSuccess(resultStrs: [String]) {
        self.navigationController?.popViewController(animated: true)
        print(resultStrs.first ?? "")
    }
    
    let share = HRQRCodeScanTool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "扫描二维码"
        share.delegate  = self
        share.beginScanInView(view: view)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}