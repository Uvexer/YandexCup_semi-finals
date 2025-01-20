import SwiftUI

// Stratum Section
struct StratumSection: View {
    @Binding var isPresented: Bool
    var frames: [UIImage]
    var onSelectImage: (UIImage) -> Void

    var body: some View {
        StratumView(isPresented: $isPresented, frames: frames, onFrameSelected: onSelectImage)
            .presentationDetents([.fraction(0.7)])
    }
}
