import SwiftUI

struct ToolSelectorView: View {
    @Binding var activeImage: String?
    @State private var showFiguresPopover = false

    var body: some View {
        HStack {
            ToolButtonView(imageName: "pencil", selectedImageName: "penciltap", activeImage: $activeImage)
            Spacer()
            ToolButtonView(imageName: "brush", selectedImageName: "brushtap", activeImage: $activeImage)
            Spacer()
            ToolButtonView(imageName: "eraser", selectedImageName: "erasertap", activeImage: $activeImage)
            Spacer()
            ToolButtonView(imageName: "figures", selectedImageName: "figurestap", activeImage: $activeImage)

            Spacer()
            ToolButtonView(imageName: "eclipsik", selectedImageName: "eclipsiktap", activeImage: $activeImage)
        }
        .padding(.horizontal, 40)
    }
}

