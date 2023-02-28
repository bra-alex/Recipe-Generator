//
//  RecipesController.swift
//  Recipe-Generator
//
//  Created by Don Bouncy on 28/02/2023.
//

import Foundation

struct Recipe: Codable{
    let id: Int
    let name: String
    let image: String
    let servings: String
    let ingredients: String
    let timeTaken: String
    let instructions: String
}

class RecipesController: ObservableObject{
    @Published var recipe: Recipe?
    
    func fetchRecipe() async {
        guard let url = URL(string: "https://recipes-api-o5ux.onrender.com/recipes/random") else {
            print("Error")
            return
        }
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            let res = response as! HTTPURLResponse
            
            if res.statusCode == 200{
                if let decodedData = try? JSONDecoder().decode(Recipe.self, from: data){
                    DispatchQueue.main.async{
                        self.recipe = decodedData
                    }
                }
            }
        } catch {
            print("Error")
        }
        
    }
}
