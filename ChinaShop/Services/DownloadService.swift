//
//  DownloadService.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 27.11.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation

typealias DownloadResponce = (urlPatch: String?, errorString: String?)

class DownloadService: NSObject, URLSessionDownloadDelegate {
    
    static public var instance = DownloadService()
    
    var activeDownloads: [String: MenuItem] = [:]
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    var delegate: DownloadServiceDelegate?
    
    public func downloadPic(forMenuItem menuItem: MenuItem) {
        
        let url = URL(string: menuItem.url!)!
        
        let task = downloadsSession.downloadTask(with: url)
        menuItem.isDownloading = true
        activeDownloads[menuItem.url!] = menuItem
        task.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url?.absoluteString else { return }
        let destinationURL = localFilePath(for: URL(string: sourceURL)!)
        var downloadResp = DownloadResponce(nil,nil)
        downloadResp.urlPatch = destinationURL.absoluteString
        //
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            print("!!File copied!!")
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        //ооо
        
        
        
        let menuItem = activeDownloads[sourceURL]!
        menuItem.isDownloading = false
        activeDownloads[sourceURL] = nil
        
        menuItem.localFilePath = destinationURL.path
        
        self.delegate?.downloadCompleated(responce: downloadResp)
    }
}

protocol DownloadServiceDelegate {
    func downloadCompleated(responce: DownloadResponce)
}
    

