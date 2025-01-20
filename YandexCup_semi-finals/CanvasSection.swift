import SwiftUI

struct CanvasSection: View {
    @Binding var selectedColor: Color
    @Binding var activeImage: String?
    @Binding var currentFrameImage: UIImage?
    @Binding var figures: [Figure]
    @Binding var frames: [UIImage]

    var body: some View {
        CanvasView(
            selectedColor: $selectedColor,
            activeImage: $activeImage,
            currentFrameImage: $currentFrameImage,
            figures: $figures,
            undoAction: {},
            redoAction: {},
            onSaveImage: { image in frames.append(image) }
        )
    }
}
