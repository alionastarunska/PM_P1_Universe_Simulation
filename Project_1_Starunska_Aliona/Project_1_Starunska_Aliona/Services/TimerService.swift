//
//  TimerService.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 27.01.2021.
//

import Foundation

protocol TimerService {
    func start()
}

class DefaultTimerService {
    private weak var timer: Timer?
    private var seconds: Int = 0
    
    init() {}
}

extension DefaultTimerService: TimerService {
    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: .interval, repeats: true, block: { [weak self] _ in
            self?.seconds += 10// Int(TimeInterval.interval)
            DispatchQueue.global().async {
                Universe.shared.handleTick(self?.seconds ?? 0)
            }
        })
        guard let timer = timer else { return }
        RunLoop.current.add(timer, forMode: .common)
    }
}

// MARK: - Constants

fileprivate extension TimeInterval {
    static let interval: TimeInterval = 1.0
}
