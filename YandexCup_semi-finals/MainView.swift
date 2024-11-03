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
                .overlay(
                  
                    Group {
                        if activeImage == "figures" {
                            HStack(spacing: 20) {
                                Image("square")
                                Image("circle")
                                Image("triangle")
                                Image("up")
                            }
                            .font(.title)
                            .padding()
                            .background(BlurView(style: .systemMaterial))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .offset(x: -30, y: -50)
                            .scaleEffect(activeImage == "figures" ? 1 : 0.8)
                            .opacity(activeImage == "figures" ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5), value: activeImage)
                        }
                    },
                    alignment: .bottomTrailing
                )
        }
        .sheet(isPresented: $isStratumViewPresented) {
            StratumView(isPresented: $isStratumViewPresented, frames: frames) { selectedImage in
                currentFrameImage = selectedImage
            }
            .presentationDetents([.fraction(0.7)])
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
