//
//  TimerService.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 27.01.2021.
//

import Foundation

/// Raw value represents number of seconds that pass in 1 second
enum Speed: Int {
    case normal = 1
    case x2 = 2
    case x5 = 5
    case max = 10
    
    var toString: String {
        switch self {
        case .normal: return "Speed: x1"
        case .x2: return "Speed: x2"
        case .x5: return "Speed: x5"
        case .max: return "Speed: x10"
        }
    }
}

protocol TimerService {
    var currentSpeed: Speed { get }
    func start()
    func speedUp()
    func slowDown()
}

class DefaultTimerService {
    private weak var timer: Timer?
    private var seconds: Int = 0
    private(set) var currentSpeed: Speed = .normal
    
    init() {}
}

extension DefaultTimerService: TimerService {
    
    func speedUp() {
        switch currentSpeed {
        case .normal: currentSpeed = .x2
        case .x2: currentSpeed = .x5
        case .x5: currentSpeed = .max
        case .max: return
        }
        start()
    }
    
    func slowDown() {
        switch currentSpeed {
        case .normal: return
        case .x2: currentSpeed = .normal
        case .max: currentSpeed = .x5
        case .x5: currentSpeed = .x2
        }
        start()
    }
    
    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: .interval / Double(currentSpeed.rawValue),
                                     repeats: true, block: { [weak self] _ in
            self?.seconds += Int(TimeInterval.interval)
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
    static let interval: TimeInterval = 10.0
}
