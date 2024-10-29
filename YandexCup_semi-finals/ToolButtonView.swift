import SwiftUI

struct ToolButtonView: View {
    let imageName: String
    let selectedImageName: String
    @Binding var activeImage: String?

    var body: some View {
        Image(activeImage == imageName ? selectedImageName : imageName)
            .resizable()
            .frame(width: 30, height: 30)
            .onTapGesture {
                activeImage = (activeImage == imageName) ? nil : imageName
            }
    }
}
