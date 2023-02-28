//
//  RecipeDetails.swift
//  Recipe-Generator
//
//  Created by Don Bouncy on 28/02/2023.
//

import SwiftUI

struct RecipeDetails: View {
    var recipe: Recipe?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20){
                VStack(alignment: .leading, spacing: 30){
                    Text(recipe?.name ?? "name")
                        .font(.largeTitle.bold())
                        .padding(.top)
                    HStack(spacing: 15) {
                        HStack {
                            Image(systemName: "clock")
                            Text(recipe?.timeTaken ?? "time taken")
                        }
                        
                        HStack {
                            Image("servings")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                            Text(recipe?.servings ?? "time taken")
                        }
                    }
                }
                .foregroundColor(.white)
                
                Divider()
                    .background(Color.white)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("ingredients")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .padding(8)
                            .background {
                                Color.white
                            }
                            .clipShape(Circle())
                            .padding(5)
                        
                        Text("Ingredients")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                    
                    Text(recipe?.ingredients ?? "Ingredients")
                        .foregroundColor(.white)
                        .lineSpacing(2)
                        .padding(.horizontal)
                }
                .padding(.bottom)
                
                Divider()
                    .background(Color.white)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("cooking")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .padding(8)
                            .background {
                                Color.white
                            }
                            .clipShape(Circle())
                            .padding(5)
                        
                        Text("Instructions")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                    
                    Text(recipe?.instructions ?? "Instructions")
                        .foregroundColor(.white)
                        .lineSpacing(2)
                        .padding(.horizontal)
                }
            }
            .padding()            
        }
        .padding(.top)
    }
}

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetails()
    }
}
