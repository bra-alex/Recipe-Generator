//
//  ContentView.swift
//  Recipe-Generator
//
//  Created by Don Bouncy on 28/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var rc = RecipesController()
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @GestureState private var gestureOffset: CGFloat = 0
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .global)
                    
                    AsyncImage(url: URL(string: rc.recipe?.image ?? "")) { img in
                        img.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height / 2)
                    .overlay {
                        Color.black.opacity(0.2)
                    }
                }
                .ignoresSafeArea()
                
                GeometryReader { proxy -> AnyView in
                    let height = proxy.frame(in: .global).height
                    return AnyView(
                        ZStack {
                            BlurView(effect: .systemThinMaterialDark)
                                .background(Color.black.opacity(0.8))
                                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                                .ignoresSafeArea()
                            VStack{
                                Capsule()
                                    .fill(.white)
                                    .frame(width: 60, height: 4)
                                    .padding(.top)
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            
                            if rc.recipe != nil{
                                RecipeDetails(recipe: rc.recipe)
                            }
                        }
                            .padding(.bottom, 20)
                            .offset(y: height - 500)
                            .offset(y: -offset > 0 ? -offset <= (height - 500) ? offset : (height - 500) : 0)
                            .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                
                                onChange()
                            }).onEnded({ value in
                                withAnimation {
                                    if -offset > 100 && -offset < height / 2{
                                        offset = -(height / 3)
                                    } else if offset > height / 2{
                                        offset = height
                                    }else{
                                        offset = 0
                                    }
                                }
                                
                                lastOffset = offset
                            }))
                    )
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .task {
                await rc.fetchRecipe()
        }
            .toolbar {
                Button {
                    Task {
                        await rc.fetchRecipe()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.black)
                        .padding(7)
                        .padding(.trailing, 5)
                }
                .background {
                    Color.white
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black.opacity(0.1), radius: 8, x: -8, y: 8)

            }
        }
    }
    func onChange(){
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
