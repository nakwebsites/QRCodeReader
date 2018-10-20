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

    //Variables needed for QR code scanning
    
    //AVCaptureSession manages the flow of data from input devices to output data.
    var captureSession = AVCaptureSession()
    //AVCaptureDevice is the capture input.
    var captureDevice: AVCaptureDevice?
    //AVCaptureVideoPreviewLayer displays the video as data is being captured
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    let qrCodeBoxView: UIView = {
        //Create the view.
        let view = UIView()
        //Default to any color for the border.
        view.layer.borderColor = UIColor.blue.cgColor
        //Border width needs to be greater than 0 to be visible.
        view.layer.borderWidth = 4
        //No frame for now.
        view.frame = CGRect.zero
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Use default video capture device
        captureDevice = AVCaptureDevice.default(for: .video);
        
        guard let device = captureDevice else { return }
        
        do {
            //Create an input with AVCaptureDeviceInput
            let input = try AVCaptureDeviceInput(device: device)
            
            //Add the input to the session.
            captureSession.addInput(input)
            
            //Create AVCaptureMetadataOutput.
            let metaDataOutput = AVCaptureMetadataOutput()
            //Add output to session.
            captureSession.addOutput(metaDataOutput)
            //Set the metadata type we want.
            metaDataOutput.metadataObjectTypes = [.qr]
            
            //Set delegate and dispatch queue that execute the response.
            metaDataOutput.setMetadataObjectsDelegate(self, queue: .main)
            
            //Start the session.
            captureSession.startRunning()
            
            //Create a AVCaptureVideoPreviewLayer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            //Video layer will be displayed by preserving the video’s aspect ratio and fill the layer’s bounds.
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            //Video layer will be your entire screen.
            videoPreviewLayer?.frame = view.layer.bounds
            //Add the layer to the parent view.
            view.layer.addSublayer(videoPreviewLayer!)
            
            //Add the box view to parent view.
            view.addSubview(qrCodeBoxView)
            
        } catch {
            print("Error Device Input")
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            //If no data, don’t have a frame.
            qrCodeBoxView.frame = CGRect.zero
            return;
        }
        
        //Cast the metadata to AVMetadataMachineReadableCodeObject.
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        //Get the string value for this object.
        guard let metadataValue = metadataObject.stringValue else { return }
        
        //If have data, ask the video preview layer to give us the data layer.
        guard let metadatLayer = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        //The frame of our box will have the bounds of the data.
        qrCodeBoxView.frame = metadatLayer.bounds;
        
        if presentedViewController != nil {
            return
        }
        
        //Create an UIAlertController, actiotSheet style.
        let alertPrompt = UIAlertController(title: "", message: "\(metadataValue)", preferredStyle: .actionSheet)
        
        //If it is an URL, add an action to open the URL.
        if let url = URL(string: metadataObject.stringValue!) {
            let confirmAction = UIAlertAction(title: "Open", style: .default, handler: { (action) -> Void in
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            alertPrompt.addAction(confirmAction)
        }
        
        //Always add cancel so user can dismiss.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertPrompt.addAction(cancelAction)
        
        //Present it to the user.
        present(alertPrompt, animated: true, completion: nil)
    }
}

