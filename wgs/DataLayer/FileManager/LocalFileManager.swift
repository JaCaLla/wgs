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


        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }

    }

    func loadImageFromDiskWith(fileName: String) -> UIImage? {

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
              //  if fileURL.pathExtension == "mp3" {
                    try FileManager.default.removeItem(at: fileURL)
              //  }
            }
        } catch  {
            print(error)
        }
    }

    func remove(filename:String) {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        do {
            if let dirPath = paths.first {
                let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(filename)
                try FileManager.default.removeItem(at: imageUrl)
            }
        } catch {
            DDLogError("ERROR: File not found")
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


