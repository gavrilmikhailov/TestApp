//
//  RuntimeError.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 18.07.2022.
//

struct RuntimeError: Error {

    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        message
    }
}
