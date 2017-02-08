//
// Created by Nickolay Sheika on 6/8/16.
//

import Foundation


internal protocol AnimationDataSource {
    func buildAnimationForImage(_ image: UIImage, forViewPortSize viewPortSize: CGSize) -> ImageAnimation
}
