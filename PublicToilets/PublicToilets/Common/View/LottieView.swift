//
//  LottieView.swift.swift
//  PublicToilets
//
//  Created by Ahmed ATIA on 29/09/2022.
//
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    var name = "animationView"
    var loopMode: LottieLoopMode = .autoReverse
    var animationView = AnimationView()

    @Binding var play: Bool

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode

        play ? animationView.play() : animationView.stop()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: LottieView

        init(_ parent: LottieView) {
            self.parent = parent
        }
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if play {
            context.coordinator.parent.animationView.play()
        } else {
            context.coordinator.parent.animationView.pause()
        }
    }
}
