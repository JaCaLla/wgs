//
//  FileManager.swift
//  wgs
//
//  Created by 08APO0516 on 08/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

final class LocalFileManager {
    
    static let shared:LocalFileManager = LocalFileManager()
    
    private init() { /* For not overwriting singleton*/ }
    
    func saveImage(imageName: String, image: UIImage) {
        
        
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)
        if !fileManager.fileExists(atPath: path as String) {
            do {
                try fileManager.createDirectory(atPath: path as String, withIntermediateDirectories: true, attributes: nil)
            } catch {
                DDLogError("\(error)")
            }
        }
        let url = NSURL(string: path as String)
        let imagePath = url!.appendingPathComponent(imageName)
        let urlString: String = imagePath!.absoluteString
        //let imageData = UIImageJPEGRepresentation(image, 0.5)
        let imageData = image.pngData()
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
        
    }
    
    func loadImage(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        
        return nil
    }
    
    func removeAllImages() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            for fileURL in fileURLs {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch  {
            DDLogError("\("error")")
        }
    }
    
    func remove(filename:String) {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let error {
                DDLogError("couldn't remove file at path \(error)")
            }
        }
    }
    
    func count() -> Int {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            return fileURLs.count
        } catch  {
            DDLogError("ERROR: Failed image count")
            return 0
        }
        return 0
    }
}

extension LocalFileManager: Resetable {
    func reset() {
        self.removeAllImages()
    }
}


