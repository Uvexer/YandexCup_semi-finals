import SwiftUI

enum FigureType {
    case square, circle, triangle, up
}

struct Figure: Identifiable {
    let id = UUID()
    var type: FigureType
    var position: CGPoint
}

struct MainView: View {
    @State private var selectedColor: Color = .black
    @State private var activeImage: String? = nil
    @State private var selectedFigureType: FigureType? = nil
    @State private var isStratumViewPresented = false
    @State private var frames: [UIImage] = []
    @State private var currentFrameImage: UIImage? = nil
    @State private var figures: [Figure] = []

    var body: some View {
        VStack {
            Spacer(minLength: 10)
            ToolbarSection(
                activeImage: $activeImage,
                isStratumViewPresented: $isStratumViewPresented
            )
            Spacer(minLength: 20)
            CanvasSection(
                selectedColor: $selectedColor,
                activeImage: $activeImage,
                currentFrameImage: $currentFrameImage,
                figures: $figures,
                frames: $frames
            )
            Spacer(minLength: 40)
            ToolSelectorSection(
                activeImage: $activeImage,
                selectedFigureType: $selectedFigureType,
                selectedColor: $selectedColor,
                addFigure: addFigure
            )
        }
        .sheet(isPresented: $isStratumViewPresented) {
            StratumSection(
                isPresented: $isStratumViewPresented,
                frames: frames,
                onSelectImage: { selectedImage in
                    currentFrameImage = selectedImage
                }
            )
        }
    }

    private func addFigure(_ type: FigureType) {
        let newFigure = Figure(type: type, position: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2))
        figures.append(newFigure)
    }
}

extension View {
    func styleOverlay() -> some View {
        font(.title)
            .padding()
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(10)
            .shadow(radius: 10)
            .offset(x: -30, y: -50)
            .scaleEffect(1)
            .animation(.easeInOut(duration: 0.5), value: true)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context _: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_: UIVisualEffectView, context _: Context) {}
}
