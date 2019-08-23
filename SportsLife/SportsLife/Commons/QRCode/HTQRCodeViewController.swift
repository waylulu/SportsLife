//
//  HTQRCodeViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/23.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import AVFoundation

@objcMembers
class HTQRCodeViewController: HTBaseViewController,AVCaptureMetadataOutputObjectsDelegate {

    private var scanRectView:UIView!
    
    private var device:AVCaptureDevice!
    private var input:AVCaptureDeviceInput!
    private var output:AVCaptureMetadataOutput!
    
    private var session:AVCaptureSession!
    private var preview:AVCaptureVideoPreviewLayer!
    private let windowSize:CGSize = UIScreen.main.bounds.size;
    
    private let qrCodeView = HTQRCode()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.session.startRunning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.session.stopRunning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
        self.loadData()
    }
    

    func configUI(){
        self.title = "扫码"
        //返回图标
        let leftBtn = UIBarButtonItem(image: UIImage(named: "Icon_Back"), style: .plain, target: self, action: #selector(BackControl))
        leftBtn.tintColor = UIColor.black
        //隐藏原始back按钮
        self.navigationItem.leftBarButtonItem = leftBtn
        
        
        //right按钮
        let rightBtn = UIBarButtonItem.init(title: "right", style: .plain, target: self, action: #selector(self.verifyRecordClick))
        rightBtn.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = rightBtn
        
        self.showQRCode()
        
    }
    
    
    func loadData(){
        
        qrCodeView.startAnimation()

    }
    
    func BackControl (){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func verifyRecordClick() {
        

        
    }
    
    //判断摄像头状态
    func cameraPermissions() -> Bool{
        
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
        
    }
    
    
    func showQRCode(){
        
        self.device = AVCaptureDevice.default(for: .video)
        
        do{
            
            self.input = try AVCaptureDeviceInput(device: device)
            
            self.output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            self.session = AVCaptureSession()
            
            if UIScreen.main.bounds.size.height<500 {
                self.session.sessionPreset = AVCaptureSession.Preset.vga640x480
            }else{
                self.session.sessionPreset = AVCaptureSession.Preset.high
            }
            
            if self.session.canAddInput(self.input){
                
                self.session.addInput(self.input)
                
            }
            
            if self.session.canAddOutput(self.output){
                
                self.session.addOutput(self.output)
                
            }
            
            
            self.output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            //计算中间可探测区域
            let scanSize:CGSize = CGSize.init(width: windowSize.width*1/2, height: windowSize.width*1/2)
            
            
            let scanRect:CGRect = CGRect(x: (windowSize.width-scanSize.width)/2, y: (windowSize.height - 94 - scanSize.height)/2, width: scanSize.width, height: scanSize.height)
            
            
            self.preview = AVCaptureVideoPreviewLayer(session:self.session)
            self.preview.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.preview.frame = UIScreen.main.bounds
            self.view.layer.insertSublayer(self.preview, at:0)
            
            //设置扫描区域
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: {[weak self] (noti) in
                
                self?.output.rectOfInterest = (self?.preview.metadataOutputRectConverted(fromLayerRect: scanRect))!
                
            })
            
            qrCodeView.frame = self.view.frame
            qrCodeView.backgroundColor = UIColor.clear
            self.view.addSubview(qrCodeView)
            qrCodeView.manualVerifBtn.addTarget(self, action: #selector(self.pushInputCodeClick), for: .touchUpInside)
            
            
            //开始捕获
            self.session.startRunning()
            
        }catch _ as NSError{
            //打印错误消息
            //            self.ShowMyAlertController("", info: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机")
            //            return
            
//            BartAlert.showAlertController(title: "提示", message: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机", target: self, actionOrNot: false, action: {
//
//            })
        }
        
        
    }
    
    //扫描结果处理
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        var stringValue:String?
        if metadataObjects.count > 0 {
            self.createSound()//扫描结果添加提示音
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            
            if stringValue != nil{
                self.session.stopRunning()
            }
        }
        self.session.stopRunning()
        
        
        let url = stringValue?.removingPercentEncoding
        if url != "" {
            //url错误处理
            if  (url! as NSString).substring(with: NSMakeRange(0, 4)) != "http"{

                let qrErrorVC = HTQRErrorViewController()
                qrErrorVC.resString = url!
                self.navigationController?.pushViewController(qrErrorVC, animated: true)
                
            }else{
                
                let webVc = HTWebViewViewController()
                webVc.url = url!
                webVc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(webVc, animated: false)
            }
            
        }else{
            print("扫描出错")
        }
        
        
    }
    
    
    func createSound() {
        //建立的SystemSoundID对象
        var soundID:SystemSoundID = 123
        //获取声音地址
        let path = Bundle.main.path(forResource: "tipsSound", ofType: "mp3")
        //地址转换
        let baseURL = NSURL(fileURLWithPath: path!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //提醒（同上面唯一的一个区别）
        AudioServicesPlayAlertSound(soundID)
    }
    
    func pushInputCodeClick() {
//        self.navigationController?.pushViewController(FillOutCaptchaController(), animated: true)
    }
    
    
    deinit {
        
    }
}
