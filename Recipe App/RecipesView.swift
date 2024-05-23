//
//  RecipesView.swift
//  Recipe App
//
//  Created by Nayeem Belal on 5/23/24.
//

import SwiftUI

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct RecipesView: View {
    @State private var meals = [Meal]()
    
    var body: some View {
        NavigationView {
            List(meals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                    HStack {
                        if let imageUrl = URL(string: meal.strMealThumb) {
                            AsyncImage(url: imageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(meal.strMeal)
                                .font(.headline)
                                .lineLimit(2)
                                .minimumScaleFactor(0.75)
                        }
                        .padding(.leading, 10)
                    }
                }
            }
            .navigationTitle("Recipes")
            .task {
                await fetchMeals()
            }
        }
    }
    func fetchMeals() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else
        {
            print("Url invalid")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                meals = decodedResponse.meals
            }
        }catch {
            print("This data is invalid!")
        }
    }
}

#Preview {
    RecipesView()
}
