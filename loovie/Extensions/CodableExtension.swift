//
//  CodableExtension.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

extension Encodable {
    
    func encode() -> Data? {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .deferredToData
        return try? encoder.encode(self)
    }
    
}

extension Decodable {
    
    static func decode(_ data: Data) -> Self? {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        return try? decoder.decode(self, from: data)
    }
    
}
