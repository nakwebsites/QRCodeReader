//
//  QRCodeReaderViewController.swift
//  QRCodeReader
//
//  Created by Daniel Tai on 10/18/18.
//  Copyright © 2018 View, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeReaderViewController : UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession?
    var captureDevice: AVCaptureDevice?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    let qrCodeBoxView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 4
        view.frame = CGRect.zero
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureDevice = AVCaptureDevice.default(for: .video);
        
        guard let device = captureDevice else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            captureSession = AVCaptureSession()
            guard let session = captureSession else { return }
            session.addInput(input)
            
            let metaDataOutput = AVCaptureMetadataOutput()
            session.addOutput(metaDataOutput)
            metaDataOutput.metadataObjectTypes = [.qr]
            
            metaDataOutput.setMetadataObjectsDelegate(self, queue: .main)
            
            session.startRunning()
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            view.addSubview(qrCodeBoxView)
            
        } catch {
            print("Error Device Input")
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeBoxView.frame = CGRect.zero
            return;
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let metadataValue = metadataObject.stringValue else { return }
        
        guard let metadatLayer = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        qrCodeBoxView.frame = metadatLayer.bounds;
        
        if presentedViewController != nil {
            return
        }
        
        let alertPrompt = UIAlertController(title: "", message: "\(metadataValue)", preferredStyle: .actionSheet)
        
        if let url = URL(string: metadataObject.stringValue!) {
            let confirmAction = UIAlertAction(title: "Open", style: .default, handler: { (action) -> Void in
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            alertPrompt.addAction(confirmAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertPrompt.addAction(cancelAction)
        
        present(alertPrompt, animated: true, completion: nil)
    }
}

