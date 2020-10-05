//
//  Network.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import Foundation
import Combine
import RealityKit

enum NetworkError: Error {
    case badRequest
    case invalidURL
}

class Network: NetworkService {
    private var downloadTask: URLSessionTask? = nil
    
    func loadModel(object3D: Object3D,
                   resultHandler: @escaping (Result<ModelEntity, Error>) -> ()) {
        
        #if DEBUG
        // If is in debug mode, Don't waste time for fetching
        if let modelURL = Bundle.main.url(forResource: "wateringcan", withExtension: "usdz") {
            do {
                let entity = try Entity.loadModel(contentsOf: modelURL)
                resultHandler(.success(entity))
            } catch let e {
                resultHandler(.failure(e))
            }
        }
        #else
        
        guard let url = object3D.networkURL else {
            resultHandler(.failure(NetworkError.invalidURL))
            return
        }
        
        downloadTask = URLSession(configuration: .default).downloadTask(with: url) {
            [weak self]
            (resultURL, response, error) in
            guard let sSelf = self else { return}

            sSelf.downloadTask = nil
            guard let localURL = resultURL else {
                if let err = error {
                    resultHandler(.failure(err))
                } else {
                    resultHandler(.failure(NetworkError.badRequest))
                }
                return
            }
            
            // Save it temporary to prevent deleting by URLSession
            let fileManager = FileManager.default
            let modelFileURL = fileManager.temporaryDirectory.appendingPathComponent("myModel.usdz")
            do {
                if fileManager.fileExists(atPath: modelFileURL.path) {
                    try fileManager.removeItem(atPath: modelFileURL.path)
                }
                try fileManager.moveItem(at: localURL, to: modelFileURL)
            } catch let e {
                resultHandler(.failure(e))
                return
            }
            
            // Load the model
            DispatchQueue.main.async {
                do {
                    let entity = try Entity.loadModel(contentsOf: modelFileURL)
                    resultHandler(.success(entity))
                } catch let e {
                    resultHandler(.failure(e))
                }
            }
        }
        downloadTask?.resume()
        
        #endif
        
        
    }
}
