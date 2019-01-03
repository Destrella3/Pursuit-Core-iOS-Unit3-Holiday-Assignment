import UIKit

class MonsterHunterWeaponsDetailViewController: UIViewController {

    var mhWeapon: MonsterHunterWeapon!
    
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var weaponName: UILabel!
    @IBOutlet weak var weaponType: UILabel!
    @IBOutlet weak var weaponDamage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfo()
        
    }
    func updateInfo() {
        weaponName.text = mhWeapon.name
        weaponType.text = mhWeapon.type.capitalized
        weaponDamage.text = "Weapon Damage: \(mhWeapon.attack.raw)"
        do {
            let imageData = try Data(contentsOf: (mhWeapon.assets?.image)!)
            weaponImage.image = UIImage.init(data: imageData)
        } catch {
            print("Error: \(error)")
        }
    }
}
