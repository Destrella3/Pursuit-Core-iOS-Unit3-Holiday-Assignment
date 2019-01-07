import UIKit

class MonsterHunterWeaponsDetailViewController: UIViewController {

    var mhWeapon: MonsterHunterWeapon!
    
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var weaponName: UILabel!
    @IBOutlet weak var weaponType: UILabel!
    @IBOutlet weak var weaponDamage: UILabel!
    @IBOutlet weak var damageType: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfo()
        
    }
    func updateInfo() {
        weaponName.text = mhWeapon.name
        weaponType.text = mhWeapon.type.capitalized
        damageType.text = "Damage Type: \(mhWeapon.attributes.damageType?.capitalized ?? "")"
        weaponDamage.text = "Weapon Damage: \(mhWeapon.attack.raw)"
        do {
            let imageData = try Data(contentsOf: (mhWeapon.assets?.image)!)
            weaponImage.image = UIImage.init(data: imageData)
        } catch {
            print("Error: \(error)")
        }
        self.weaponImage.layer.cornerRadius = self.weaponImage.frame.size.width / 2
        self.weaponImage.clipsToBounds = true
        self.weaponImage.layer.borderWidth = 3
    }
}
