//
//  ScanViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 5/21/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Vision


class ScanViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var captureSession: AVCaptureSession!
    var backCamera: AVCaptureDevice?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var captureOutput: AVCapturePhotoOutput?
    
    var shutterButton: UIButton!
    
    @IBOutlet weak var barButtonBack: UIBarButtonItem!
    
    lazy var detectBarcodeRequest: VNDetectBarcodesRequest = {
        return VNDetectBarcodesRequest(completionHandler: { (request, error) in
            guard error == nil else {
                self.showAlert(withTitle: "barcode Error", message: error!.localizedDescription)
                return
            }
            
            self.processClassification(for: request)
        })
    }()
    
    
    //MARK: ViewController Init
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkPermissions()
    }
    
    
    func loadData() {
        checkPermissions()
        setupCameraLiveView()
        addShutterButton()
    }
    
    //MARK: Camera Init
    private func setupCameraLiveView() {
        // Set up the camera session.
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd1280x720

        // Set up the video device.
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                                      mediaType: AVMediaType.video,
                                                                      position: .back)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
        }

        // Make sure the actually is a back camera on this particular iPhone.
        guard let backCamera = backCamera else {
            showAlert(withTitle: "Camera error", message: "There seems to be no camera on your device.")
            return
        }

        // Set up the input and output stream.
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(captureDeviceInput)
        } catch {
            showAlert(withTitle: "Camera error", message: "Your camera can't be used as an input device.")
            return
        }

        // Initialize the capture output and add it to the session.
        captureOutput = AVCapturePhotoOutput()
        captureOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        captureSession.addOutput(captureOutput!)
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer!.videoGravity = .resizeAspectFill
        cameraPreviewLayer!.connection?.videoOrientation = .portrait
        cameraPreviewLayer?.frame = view.frame

        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)

        // Start the capture session.
        captureSession.startRunning()
    }

    

    
    private func addShutterButton() {
        let width: CGFloat = 75
        let height = width
        shutterButton = UIButton(frame: CGRect(x: (view.frame.width - width) / 2,
                                               y: view.frame.height - height - 32,
                                               width: width,
                                               height: height
            )
        )
        shutterButton.layer.cornerRadius = width / 2
        shutterButton.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.8)
        shutterButton.showsTouchWhenHighlighted = true
        shutterButton.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
        view.addSubview(shutterButton)
    }
    
    
    //MARK: Photo Capture Logic
    
    @objc func captureImage() {
        let settings = AVCapturePhotoSettings()
        captureOutput?.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(),
            let image = UIImage(data: imageData) {
                
            guard let ciImage = CIImage(image: image) else {
                fatalError("Unable to create image!")
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                let handler = VNImageRequestHandler(ciImage: ciImage, orientation: CGImagePropertyOrientation.up, options: [:])

                do {
                    try handler.perform([self.detectBarcodeRequest])
                } catch {
                    self.showAlert(withTitle: "Error Decoding Barcode", message: error.localizedDescription)
                }
            }
            
        }
    }
    
    func processClassification(for request: VNRequest) {
        DispatchQueue.main.async {
            if let bestResult = request.results?.first as? VNBarcodeObservation,
                let payload = bestResult.payloadStringValue {
                //self.showInfo(for: payload)

                //add logic to check if item is in inventory, if not, present "add new item" screen and then pop back
                //if item does exist, add / remove based on the (currently nonexistent) options on this screen
                //currently just presenting inventory view
                let storyboard: UIStoryboard = UIStoryboard(name: "Inventory", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Inventory") as! InventoryViewController
                viewController.modalPresentationStyle = .overCurrentContext
                viewController.newlyScannedItem = payload
                self.present(viewController, animated: true, completion: nil)
                
            } else {
                //TODO: Start timer on fail instead of immediately throwing an error
                //Capture and process an image every .5 sec for 10 tries, after 10 fails throw an error and stop timer
                self.showAlert(withTitle: "Unable to extract Results", message: "Cannot extract barcode info.")
            }
        }
    }
    
    
    
    //MARK: Scanning Permissions
    private func checkPermissions() {
        let mediaType = AVMediaType.video
        let status = AVCaptureDevice.authorizationStatus(for: mediaType)

        switch status {
        case .denied, .restricted:
            displayNotAuthorizedUI()
        case .notDetermined:
            // Prompt the user for access.
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                guard granted != true else { return }

                // The UI must be updated on the main thread.
                DispatchQueue.main.async {
                    self.displayNotAuthorizedUI()
                }
            }

        default: break
        }
    }
        
    private func displayNotAuthorizedUI() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.8, height: 20))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Please grant access to the camera for scanning barcodes."
        label.sizeToFit()

        let button = UIButton(frame: CGRect(x: 0, y: label.frame.height + 8, width: view.frame.width * 0.8, height: 35))
        button.layer.cornerRadius = 10
        button.setTitle("Grant Access", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 4.0/255.0, green: 92.0/255.0, blue: 198.0/255.0, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)

        let containerView = UIView(frame: CGRect(
            x: view.frame.width * 0.1,
            y: (view.frame.height - label.frame.height + 8 + button.frame.height) / 2,
            width: view.frame.width * 0.8,
            height: label.frame.height + 8 + button.frame.height
            )
        )
        containerView.addSubview(label)
        containerView.addSubview(button)
        view.addSubview(containerView)
    }
   
    @objc private func openSettings() {
        let settingsURL = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(settingsURL) { _ in
            self.checkPermissions()
        }
    }

    //MARK: Helper Functions
    private func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    
    func showInfo(for payload: String) {
        showAlert(withTitle: "SKU", message: payload)
    }
    
    //MARK: Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

