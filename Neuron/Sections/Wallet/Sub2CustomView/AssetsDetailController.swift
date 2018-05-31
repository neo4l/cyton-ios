//
//  AssetsDetailController.swift
//  Neuron
//
//  Created by XiaoLu on 2018/5/23.
//  Copyright © 2018年 cryptape. All rights reserved.
//

import UIKit

protocol AssetsDetailControllerDelegate: NSObjectProtocol {
    func didClickPay()
    func didClickGet()
}

class AssetsDetailController: BaseViewController {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var getButtton: UIButton!
    weak var delegate:AssetsDetailControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH)
        
    }
    
    @IBAction func closeMyselfBtn(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
    @IBAction func didClickPayBtn(_ sender: UIButton) {
        delegate?.didClickPay()
        self.view.removeFromSuperview()
    }
    
    @IBAction func didClickGetBtn(_ sender: UIButton) {
        delegate?.didClickGet()
        self.view.removeFromSuperview()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}