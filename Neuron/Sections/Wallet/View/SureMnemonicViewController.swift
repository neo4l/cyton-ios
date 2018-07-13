//
//  SureMnemonicViewController.swift
//  Neuron
//
//  Created by XiaoLu on 2018/6/1.
//  Copyright © 2018年 cryptape. All rights reserved.
//

import UIKit

class SureMnemonicViewController: BaseViewController,ButtonTagViewDelegate,ButtonTagUpViewDelegate,SureMnemonicViewModelDelegate {

    private var showView : ButtonTagView! = nil
    private var selectView : ButtonTagUpView! = nil
    private var selectArray:Array<String> = []
    
    let sureButton = UIButton.init(type: .custom)
    
    
    private var titleArr:Array<String> = []
    var viewModel = SureMnemonicViewModel()
    var password = ""
    var mnemonic:String?{
        didSet{
            titleArr =  (mnemonic?.components(separatedBy: " "))!
        }
    }
    
    
    var walletModel = WalletModel(){
        didSet{
            viewModel.walletModel = walletModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "确认助记词"
        didDrawSubViews()
        viewModel.delegate = self
    }
    
    func didDrawSubViews() {
        
        selectView = ButtonTagUpView.init(frame: CGRect(x: 15, y: 15+35, width: ScreenW - 30, height: 150))
        selectView.backgroundColor = ColorFromString(hex: "#f5f5f5")
        selectView.delegate = self
        view.addSubview(selectView)
        
        showView = ButtonTagView.init(frame: CGRect(x: 15, y: 15+35 + 150 , width: ScreenW - 30, height: 150))
        showView.delegate = self
        showView.titleArray = titleArr.shuffle()
        showView.backgroundColor = .white
        view.addSubview(showView)
        
        sureButton.frame = CGRect(x: 15, y: showView.frame.origin.y + showView.frame.size.height + 20, width: ScreenW - 30, height: 44)
        sureButton.backgroundColor = ColorFromString(hex: "#f2f2f2")
        sureButton.setTitleColor(ColorFromString(hex: "#999999"), for: .normal)
        sureButton.setTitle("完成备份", for: .normal)
        sureButton.addTarget(self, action: #selector(didCompletBackupMnemonic), for: .touchUpInside)
        sureButton.layer.cornerRadius = 5
        view.addSubview(sureButton)
        
    }
    
    //选择按钮的时候返回的选择的数组
    func callBackSelectButtonArray(array: Array<NSMutableDictionary>) {
        selectView.comArr = array
        selectArray.removeAll()
        for name in array {
//            print(name.value(forKey: "buttonTitle") as! String)
            selectArray.append(name.value(forKey: "buttonTitle") as! String)
        }
        if selectArray.count == 12 {
            sureButton.isEnabled = true
            sureButton.backgroundColor = ColorFromString(hex: themeColor)
            sureButton.setTitleColor(.white, for: .normal)
        }else{
            sureButton.isEnabled = false
            sureButton.backgroundColor = ColorFromString(hex: "#f2f2f2")
            sureButton.setTitleColor(ColorFromString(hex: "#999999"), for: .normal)
        }
        print(selectArray)
    }

    
    //点击删除按钮的时候 下方按钮改变选中状态
    func didDeleteSelectedButton(backDict: NSMutableDictionary) {
        showView.deleteDict = backDict
        selectArray = selectArray.filter({ (title) -> Bool in
            return  backDict.value(forKey: "buttonTitle") as! String != title
        })
        print(selectArray)
    }
    
    @objc func didCompletBackupMnemonic(){
        if selectArray.count != titleArr.count {
            NeuLoad.showToast(text: "助记词验证失败")
            return
        }
        let originalMnemonic = titleArr.joined()
        let selectMnemonic = selectArray.joined()
        let success = viewModel.compareMnemonic(original: originalMnemonic, current: selectMnemonic)
        if success { viewModel.didImportWalletToRealm(mnemonic: mnemonic!, password: password) }
    }

    func doPush() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}