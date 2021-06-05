//
//  NumberListViewModel.swift
//  FuturePromiseDemo_SwiftUI
//
//  Created by Josh R on 6/4/21.
//

import Foundation
import Combine

class NumberListViewModel: ObservableObject {
    @Published var numbers = [1, 2, 3]
    @Published var isDownloading = false

    private var cancellables = Set<AnyCancellable>()

    private let service: NumberGeneratorServiceProtocol

    init(service: NumberGeneratorServiceProtocol = NumberGeneratorService()) {
        self.service = service

        getNumbers()
    }

    func getNumbers() {
        isDownloading = true
        service.generateNumbers()
            .delay(for: 2, scheduler: RunLoop.current)  //mimics a network fetch
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.isDownloading = false
                print("The numbers finished generating.")
            }
        } receiveValue: { [weak self] randomNumbers in
            self?.numbers = randomNumbers
        }.store(in: &cancellables)
    }

    var numberFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .spellOut
        return f
    }

    func spellOut(number: Int) -> String {
        let nsNumber = NSNumber(value: number)
        return numberFormatter.string(from: nsNumber) ?? "N/A"
    }
}
