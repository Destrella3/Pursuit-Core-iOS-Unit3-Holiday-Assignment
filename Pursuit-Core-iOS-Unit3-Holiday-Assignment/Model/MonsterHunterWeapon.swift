import Foundation

struct MonsterHunterWeapon: Codable {
    struct OuterLayer: Codable {
        let mhWeapons: MonsterHunterWeapon
    }
    let name: String
    let type: String
    let attributes: Attributes
    let attack: Attack
    let assets: Assets?
    struct Attributes: Codable {
        let damageType: String?
    }
    struct Attack: Codable {
        let display: Int
        let raw: Int
    }
    struct Assets: Codable {
        let icon: URL?
        let image: URL?
    }
}
















