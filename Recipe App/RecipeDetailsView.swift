import SwiftUI
import Foundation

struct MealDetail: Codable {
    let meals: [MealDetailInfo]
}

struct MealDetailInfo: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    
    // Ingredients indivisually
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    var ingredients: [String] {
        [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
         strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
         strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
         strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20].compactMap { $0?.isEmpty == false ? $0 : nil }
    }
    
    // Do the same for the measures
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    var measurements: [String] {
        [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
         strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
         strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
         strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20]
         .compactMap { $0?.isEmpty == false ? $0 : nil }
    }
}
struct MealDetailView: View {
    let mealID: String
    @State private var mealDetail: MealDetailInfo?

    var body: some View {
        ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let mealDetail = mealDetail {
                            AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .padding(.top)

                            Text(mealDetail.strMeal)
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Instructions:")
                                .font(.headline)

                            Text(mealDetail.strInstructions)
                                .padding(.bottom)

                            Text("Ingredients and Measurements:")
                                .font(.headline)

                            ForEach(Array(zip(mealDetail.ingredients, mealDetail.measurements)), id: \.0) { ingredient, measurement in
                                HStack {
                                    Text("\(ingredient):")
                                        .bold()
                                    Spacer()
                                    Text(measurement)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 2)
                            }
                        } else {
                            ProgressView("Loading...")
                        }
                    }
                    
                }
        .padding()
        .navigationTitle("Meal Details")
        .task {
            await fetchMealDetail()
        }
    }

    func fetchMealDetail() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(MealDetail.self, from: data)
            mealDetail = decodedResponse.meals.first
        } catch {
            print("Failed to load or decode meal detail data:", error)
        }
    }
}

#Preview {
    MealDetailView(mealID: "53049")
}
