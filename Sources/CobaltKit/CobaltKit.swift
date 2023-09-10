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
    public func startDownload(req: CobaltRequest, endpoint: String = "https://co.wuk.sh", _ callback: @escaping (URL?, Error?) -> Void, statusUpdate: ((String) -> Void)?, percentageUpdate: ((Double) -> Void)?) async {
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
                        var session = urlSession.downloadTask(with: URL(string: (response?.url!)!)!) { media, res, err in
                            if let err = err {
                                callback(nil, err)
                                return
                            }
                            if let statusUpdate = statusUpdate {
                                statusUpdate("Download complete!")
                            }
                            
                            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let destinationURL = documentsDirectory.appendingPathComponent("downloadedVideo.mp4")
                            
                            do {
                                do {
                                    try FileManager.default.removeItem(at: destinationURL)
                                } catch {
                                    callback(nil, error)
                                }
                                try FileManager.default.moveItem(at: media!, to: destinationURL)
                            } catch {
                                callback(nil, error)
                                return
                            }
                            callback(destinationURL, nil)
                        }

                        // Add an observer for the progress property of the download task
                        var progressObserver: NSKeyValueObservation?

                        progressObserver = session.observe(\.progress, options: [.new], changeHandler: { (_, change) in
                            print("update")
                            if let percentageUpdate = percentageUpdate {
                                percentageUpdate(change.newValue!.fractionCompleted ?? 0.0)
                            }
                        })

                        // Resume the download task
                        session.resume()
                        
                        
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
