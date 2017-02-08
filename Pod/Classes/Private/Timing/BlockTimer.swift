//
// Created by Nickolay Sheika on 6/11/16.
//

import Foundation

class BlockTimer {

    // MARK: - Private Variables

    fileprivate let repeats: Bool
    fileprivate var timer: Timer?
    fileprivate var callback: (() -> ())? // callback is retained, but cancel() will drop it and therefore break retain cycle
    fileprivate var timeLeftToFire: TimeInterval?

    // MARK: - Init

    init(interval: TimeInterval, repeats: Bool = false, callback: @escaping () -> ()) {
        self.repeats = repeats
        self.callback = callback

        timer = buildTimerAndScheduleWithTimeInterval(interval, repeats: repeats)
    }

    // MARK: - Public

    func pause() {
        timeLeftToFire = timer?.fireDate.timeIntervalSinceNow

        timer?.invalidate()
        timer = nil
    }

    func resume() {
        guard timeLeftToFire != nil else {
            return
        }

        timer = buildTimerAndScheduleWithTimeInterval(timeLeftToFire!, repeats: repeats)
    }

    func cancel() {
        timer?.invalidate()
        timer = nil
        callback = nil
    }

    @objc func timerFired(_ timer: Timer) {
        callback?()

        if !repeats {
            cancel()
        }
    }

    // MARK: - Private

    fileprivate func buildTimerAndScheduleWithTimeInterval(_ timeInterval: TimeInterval, repeats: Bool) -> Timer {
        let timer = Timer(timeInterval: timeInterval,
                            target: self,
                            selector: #selector(timerFired),
                            userInfo: nil,
                            repeats: repeats)

        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)

        return timer
    }
}
