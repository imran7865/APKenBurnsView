//
// Created by Nickolay Sheika on 6/8/16.
//

import Foundation


enum TransitionEffect {
    case transitionEffectCrossFade
}

struct Transition {
    let imageTransition: ImageAnimation

    let transitionEffect: TransitionEffect = .transitionEffectCrossFade
    let transitionDuration: Double
}

struct ImageAnimation {
    let startState: ImageState
    let endState: ImageState

    let duration: Double
}

struct ImageState {
    let scale: CGFloat
    let position: CGPoint
}

struct ImageAnimationDependencies {
    let scaleFactorDeviation: Float

    let imageAnimationDuration: Double
    let imageAnimationDurationDeviation: Double
}
