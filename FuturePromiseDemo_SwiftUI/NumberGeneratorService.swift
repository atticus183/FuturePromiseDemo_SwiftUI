//
//  NumberGeneratorService.swift
//  FuturePromiseDemo_SwiftUI
//
//  Created by Josh R on 6/4/21.
//

import Foundation
import Combine

protocol NumberGeneratorServiceProtocol: AnyObject {
    func generateNumbers() -> Future<[Int], Never>
}

class NumberGeneratorService: NumberGeneratorServiceProtocol {
    func generateNumbers() -> Future<[Int], Never> {
        return Future { promise in
            let randomNumbers = Array(1...50).map { $0 * Int.random(in: 1...10) }
            promise(.success(randomNumbers))
        }
    }
}
