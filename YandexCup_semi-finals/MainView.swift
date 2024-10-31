import SwiftUI

struct MainView: View {
    @State private var activeImage: String? = nil
    @State private var isStratumViewPresented = false
    @State private var frames: [UIImage] = []
    @State private var currentFrameImage: UIImage? = nil  
    var body: some View {
        VStack {
            Spacer(minLength: 10)

            ToolbarView(
                clearAction: {
                    activeImage = "trash"
                },
                undoAction: {
                    activeImage = "left"
                },
                redoAction: {
                    activeImage = "right"
                },
                saveFrameAction: {
                    activeImage = "clear"
                },
                stratumAction: {
                    isStratumViewPresented = true
                }
            )

            Spacer(minLength: 20)

            CanvasView(
                activeImage: $activeImage,
                currentFrameImage: $currentFrameImage,
                undoAction: {},
                redoAction: {},
                onSaveImage: { image in
                    frames.append(image)
                }
            )

            Spacer(minLength: 40)

            ToolSelectorView(activeImage: $activeImage)
        }
        .sheet(isPresented: $isStratumViewPresented) {
            StratumView(isPresented: $isStratumViewPresented, frames: frames) { selectedImage in
                currentFrameImage = selectedImage
            }
            .presentationDetents([.fraction(0.7)])
        }
    }
}
