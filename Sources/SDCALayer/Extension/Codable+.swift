//
//  Codable+.swift
//  
//
//  Created by p-x9 on 2022/11/08.
//  
//

import Foundation
import Yams

extension Encodable {
    private static var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        // Do not sort because the order of SUBLAYER should not change.
        encoder.outputFormatting = [.prettyPrinted]
        return encoder
    }

    private static var yamlEncoder: YAMLEncoder {
        let encoder = YAMLEncoder()
        return encoder
    }

    var jsonString: String?  {
        guard let data = try? Self.jsonEncoder.encode(self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    var yamlString: String? {
        try? Self.yamlEncoder.encode(self)
    }
}

extension Decodable {
    private static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }

    private static var yamlDecoder: YAMLDecoder {
        let decoder = YAMLDecoder()
        return decoder
    }

    static func value(fromJSON string: String) -> Self? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        return try? Self.jsonDecoder.decode(Self.self, from: data)
    }

    static func value(fromYAML string: String) -> Self? {
        try? Self.yamlDecoder.decode(from: string)
    }
}
