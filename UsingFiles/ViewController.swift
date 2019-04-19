//
//  ViewController.swift
//  UsingFiles
//
//  Created by Tim Richardson on 10/05/2018.
//  Copyright © 2018 iOS Mastery. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    @IBAction func writeFiles(_ sender: Any) {
        
        let file = "\(UUID().uuidString).txt"
        let contents = "Some text..."
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            try contents.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    @IBAction func importFiles(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String, kUTTypePDF as String, kUTTypePNG as String, kUTTypeJPEG as String, kUTTypeImage as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}

extension ViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            return
        }
//        self.uploadFiles([selectedFileURL])
        
        do {
            let data2 = try Data.init(contentsOf: URL.init(string: selectedFileURL.absoluteString)!)
            print(data2.count)
        } catch {
            print(error.localizedDescription)
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(dir)
        
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("Already exists! Do nothing")
        }
        else {
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                print("Copied file!")
            }
            catch {
                print("Error: \(error)")
            }
        }
    }
    
//    func uploadFiles(_ urlPath: [URL]){
//
//        if let imgURLs : [URL] = urlPath {
//            for f in imgURLs {
//                let filename = f.lastPathComponent
//                let splitName = filename.split(separator: ".")
//                let name = String(describing: splitName.first)
//                let filetype = String(describing: splitName.last)
//
//                let imgBoundary = "\r\n--\(boundary)\r\nContent-Type: image/\(filetype)\r\nContent-Disposition: form-data; filename=\(filename); name=\(name)\r\n\r\n"
//
//                if let d = imgBoundary.data(using: .utf8) {
//                    bodyData.append(d)
//                }
//
//                do {
//                    let imgData = try Data(contentsOf:f, options:[])
//                    bodyData.append(imgData)
//                }
//                catch {
//                    // can't load image data
//                }
//
//        }
//        let closingBoundary = "\r\n--\(boundary)--"
//        if let d = closingBoundary.data(using: .utf8) {
//            bodyData.append(d)
//        }
//
//        if let url = URL(string: "https://beirutiyat.info/MobileApp/job/addjob/"){
//            var request = URLRequest(url: url)
//            let boundary:String = "Boundary-\(UUID().uuidString)"
//
//            request.httpMethod = "POST"
//            request.timeoutInterval = 10
//            request.allHTTPHeaderFields = ["Content-Type": "multipart/form-data; boundary=----\(boundary)"]
//
//            for path in urlPath{
//                do{
//                    var data2: Data = Data()
//                    var data: Data = Data()
//                    data2 = try NSData.init(contentsOf: URL.init(fileURLWithPath: path.absoluteString, isDirectory: true)) as Data
//                    //Use this if you have to send a JSON too.
//
//                     let dic:[String:Any] = [
//                     "Key":"",
//                     "Key":""
//                     ]
//
//                     for (key,value) in dic{
//                     data.append("------\(boundary)\r\n")
//                     data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                     data.append("\(value)\r\n")
//                     }
//
//                    data.append("------\(boundary)\r\n")
//                    //Here you have to change the Content-Type
//                    data.append("Content-Disposition: form-data; name=\"file\"; filename=\"YourFileName\"\r\n")
//                    data.append("Content-Type: application/YourType\r\n\r\n")
//                    data.append(data2)
//                    data.append("\r\n")
//                    data.append("------\(boundary)--")
//
//                    request.httpBody = data
//                }catch let e{
//                    //Your errors
//                }
//                DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).sync {
//                    let session = URLSession.shared
//                    let task = session.dataTask(with: request, completionHandler: { (dataS, aResponse, error) in
//                        if let erros = error{
//                            //Your errors
//                        }else{
//                            do{
//                                let responseObj = try JSONSerialization.jsonObject(with: dataS!, options: JSONSerialization.ReadingOptions(rawValue:0)) as! [String:Any]
//
//                            }catch let e{
//
//                            }
//                        }
//                    }).resume()
//                }
//            }
//        }
}




























