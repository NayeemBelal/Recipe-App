
import SwiftUI

struct LandingView: View {
    let title = "Cook up a feast!"
    @State var isPressed = false
    @State var isHovered = false
    var body: some View {
        GeometryReader { geometry in
                    ZStack {
                        Color.white
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            Image("landingImg")
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height / 1.2)
                                .clipped()
                                .edgesIgnoringSafeArea(.top)
                            Spacer()
                        }
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .bottom, endPoint: .top)
                            .frame(height: geometry.size.height / 1.95)
                                            .edgesIgnoringSafeArea(.all)
                        
                        Text(title)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(20)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.2)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        
                        VStack {
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Text("See Recipes")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 15)
                                    .padding(.horizontal, 70)
                                    .background(

                                        Capsule()
                                            .fill(Color.brown)
                                    )
                            })
                            .padding(.bottom, 40)
                        }
                    }
                }
    }
}

#Preview {
    LandingView()
}
