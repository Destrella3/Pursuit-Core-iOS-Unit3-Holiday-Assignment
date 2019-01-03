import Foundation

enum AppError {
    case badURL(String)
    case badData(Error)
    case badDecoding(Error)
}

final class MonsterHunterWeaponsAPIClient {
    static func getAllWeapons(completionHandler: @escaping (([MonsterHunterWeapon]?, AppError?) -> Void)) {
        guard let url = URL.init(string: "https://mhw-db.com/weapons") else {
            completionHandler(nil, .badURL("URL not found"))
            return
        }
        var urlRequest = URLRequest.init(url: url)
        urlRequest.addValue("", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            if let data = data {
                do {
                    let weaponData = try JSONDecoder().decode([MonsterHunterWeapon].self, from: data)
                    
                    
                    completionHandler(weaponData, nil)
                } catch {
                    completionHandler(nil, .badDecoding(error))
                }
            }
        }.resume()
    }
}
