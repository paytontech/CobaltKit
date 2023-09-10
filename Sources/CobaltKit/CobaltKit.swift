//
//  CobaltManager.swift
//  CobaltNative
//
//  Created by Payton Curry on 7/16/23.
//

import Foundation
import Combine
public class CobaltManager: NSObject, ObservableObject {
    //params according to Cobalt API parameters & default values if applicable
    //DOCS:
    //-_ callback: returns file path URL of downloaded video. also returns Error if there was an error
    //-statusUpdate: periodically called to provide human-readable updates on download progress
    //-the class also has a published var called dlPercentage which contains a 0-1 percentage for the download. use is optional.
    @Published var dlPercentage: Double = 0
    static func startDownload(req: CobaltRequest, endpoint: String = "https://co.wuk.sh", _ callback: @escaping (URL?, Error?) -> Void, statusUpdate: ((String) -> Void)?) async {
        var response: CobaltResponse?
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        let urlSession = URLSession.shared
        let reqData = String(data: try! encoder.encode(req), encoding: .utf8)
        let reqUrl = URL(string: "\(endpoint)/api/json")!
        var request = URLRequest(url: reqUrl)
        request.httpMethod = "POST"
        request.httpBody = (try! encoder.encode(req))
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("Started request to \(endpoint)/api/json w/ data \(reqData!)")
        urlSession.dataTask(with: request) { data, res, err in
            print("got things")
            if let statusUpdate = statusUpdate {
                statusUpdate("Recieved initial data")
            }
            if let data = data {
                response = try! JSONDecoder().decode(CobaltResponse.self, from: data)
                if response?.status != .error {
                    if response?.status == .stream {
                        if let statusUpdate = statusUpdate {
                            statusUpdate("Now downloading...")
                        }
                        urlSession.downloadTask(with: URL(string: (response?.url!)!)!) { media, res, err in
                            if let err = err {
                                callback(nil, err)
                                return
                            }
                                if let statusUpdate = statusUpdate {
                                    statusUpdate("Download complete!")
                                }
                                
                                callback(media!, nil)
                            
                        }.resume()
                        
                        
                    } else {
                        callback(URL(string: response!.url!)!, nil)
                    }
                } else {
                    callback(nil, CobaltError.itsFucked)
                }
            } else {
                print(res, err)
            }
        }.resume()
        
    }
}
extension CobaltManager: URLSessionDownloadDelegate {
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        self.dlPercentage = (Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)) / Double(100)
    }
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        self.dlPercentage = 1
    }
}
