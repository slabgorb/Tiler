//
//  FileSaveHelper.swift
//  Tiler
//
//  Created by Keith Avery on 3/26/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation
import UIKit

class FileSaveHelper {
    
    // MARK:- Error Types
    private enum FileErrors:ErrorType {
        case JsonNotSerialized
        case FileNotSaved
        case ImageNotConvertedToData
        case FileNotRead
        case FileNotFound
    }
    
    // MARK:- File Extension Types
    enum FileExtension:String {
        case TXT = ".txt"
        case JPG = ".jpg"
        case JSON = ".json"
    }
    
    // MARK:- Private Properties
    private let directory:NSSearchPathDirectory
    private let directoryPath: String
    private let fileManager = NSFileManager.defaultManager()
    private let fileName:String
    private let filePath:String
    private let fullyQualifiedPath:String
    private let subDirectory:String
    
    
    var fileExists:Bool {
        get {
            return fileManager.fileExistsAtPath(fullyQualifiedPath)
        }
    }
    
    var directoryExists:Bool {
        get {
            var isDir = ObjCBool(true)
            return fileManager.fileExistsAtPath(filePath, isDirectory: &isDir )
        }
    }
    
    convenience init(fileName:String, fileExtension:FileExtension){
        self.init(fileName:fileName, fileExtension:fileExtension, subDirectory:"", directory:.DocumentDirectory)
    }

    convenience init(fileName:String, fileExtension:FileExtension, subDirectory:String){
        self.init(fileName:fileName, fileExtension:fileExtension, subDirectory:subDirectory, directory:.DocumentDirectory)
    }
    
    init(fileName:String, fileExtension:FileExtension, subDirectory:String, directory:NSSearchPathDirectory){
        self.fileName = fileName + fileExtension.rawValue
        self.subDirectory = "/\(subDirectory)"
        self.directory = directory
        self.directoryPath = NSSearchPathForDirectoriesInDomains(directory, .UserDomainMask, true)[0]
        self.filePath = directoryPath + self.subDirectory
        self.fullyQualifiedPath = "\(filePath)/\(self.fileName)"
        createDirectory()
    }

    private func createDirectory(){
        if !directoryExists {
            do {
                try fileManager.createDirectoryAtPath(filePath, withIntermediateDirectories: false, attributes: nil)
            }
            catch {
                print("An Error was generated creating directory")
            }
        }
    }

    /** 
     Save an image file 
     
     - Parameter image: image to save
    */
    func saveFile(image image:UIImage) throws {
        guard let data = UIImageJPEGRepresentation(image, 1.0) else {
            throw FileErrors.ImageNotConvertedToData
        }
        if !fileManager.createFileAtPath(fullyQualifiedPath, contents: data, attributes: nil){
            throw FileErrors.FileNotSaved
        }
    }
    
    /** 
     Save a plaintext file.
     
     - Parameter string: string to save to disk
     */
    func saveFile(string fileContents:String) throws{
        do {
            try fileContents.writeToFile(fullyQualifiedPath, atomically: true, encoding: NSUTF8StringEncoding)
        }
        catch  {
            throw error
        }
    }
    
    /**
     Save a plaintext file.
     
     Parameter dataForJson: data to convert to JSON format ans save
     
     */
    func saveFile(dataForJson dataForJson:AnyObject) throws{
        do {
            let jsonData = try convertObjectToData(dataForJson)
            if !fileManager.createFileAtPath(fullyQualifiedPath, contents: jsonData, attributes: nil){
                throw FileErrors.FileNotSaved
            }
        } catch {
            print(error)
            throw FileErrors.FileNotSaved
        }
        
    }
    
    private func convertObjectToData(data:AnyObject) throws -> NSData {
        
        do {
            let newData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
            return newData
        }
        catch {
            print("Error writing data: \(error)")
        }
        throw FileErrors.JsonNotSerialized
    }
    
    /**
     Read the contents of a text file
     */
    func getContentsOfFile() throws -> String {
        guard fileExists else { throw FileErrors.FileNotFound }
        
        var returnString:String
        do {
            returnString = try String(contentsOfFile: fullyQualifiedPath, encoding: NSUTF8StringEncoding)
        } catch {
            throw FileErrors.FileNotRead
        }
        return returnString
    }
    
    /**
     Read an image from a file
     */
    func getImage() throws -> UIImage {
        guard fileExists else {
            throw FileErrors.FileNotFound
        }
        
        guard let image = UIImage(contentsOfFile: fullyQualifiedPath) else {
            throw FileErrors.FileNotRead
        }
        
        return image
    }
    
    /**
     Reads and parses a json file, returns a dict
     */
    func getJSONData() throws -> NSDictionary {
        guard fileExists else { throw FileErrors.FileNotFound }
        do {
            let data = try NSData(contentsOfFile: fullyQualifiedPath, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            return jsonDictionary
        } catch {
            throw FileErrors.FileNotRead
        }
    }
    
}