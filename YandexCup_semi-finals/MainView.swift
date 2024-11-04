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
    @State private var activeImage: String? = nil
    @State private var selectedFigureType: FigureType? = nil
    @State private var isStratumViewPresented = false
    @State private var frames: [UIImage] = []
    @State private var currentFrameImage: UIImage? = nil
    @State private var figures: [Figure] = []

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
                figures: $figures,
                undoAction: {},
                redoAction: {},
                onSaveImage: { image in
                    frames.append(image)
                }
            )

            Spacer(minLength: 40)

            ToolSelectorView(activeImage: $activeImage, selectedFigure: $selectedFigureType)
                .overlay(
                    Group {
                        if activeImage == "figures" {
                            HStack(spacing: 20) {
                                Image("square").onTapGesture { addFigure(.square) }
                                Image("circle").onTapGesture { addFigure(.circle) }
                                Image("triangle").onTapGesture { addFigure(.triangle) }
                                Image("up").onTapGesture { addFigure(.up) }
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
                        } else if activeImage == "eclipsik" {
                            HStack(spacing: 20) {
                                Image("drawer").onTapGesture { addEclipsik("drawer") }
                                Image("circle1").onTapGesture { addEclipsik("circle1") }
                                Image("circle2").onTapGesture { addEclipsik("circle2") }
                                Image("circle3").onTapGesture { addEclipsik("circle3") }
                                Image("circle4").onTapGesture { addEclipsik("circle4") }
                            }
                            .font(.title)
                            .padding()
                            .background(BlurView(style: .systemMaterial))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .offset(x: -30, y: -50)
                            .scaleEffect(activeImage == "eclipsik" ? 1 : 0.8)
                            .opacity(activeImage == "eclipsik" ? 1 : 0)
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

    private func addFigure(_ type: FigureType) {
        let newFigure = Figure(type: type, position: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2))
        figures.append(newFigure)
    }

    private func addEclipsik(_ name: String) {
        
    }
}


struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
