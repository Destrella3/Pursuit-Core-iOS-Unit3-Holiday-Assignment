import UIKit

class MonsterHunterWeaponController: UIViewController {

    private var monsterHunterWeapons = [MonsterHunterWeapon]() {
        didSet {
            DispatchQueue.main.async {
                self.mhWeaponTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var mhWeaponTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mhWeaponTableView.layer.borderWidth = 2.0
        title = "Monster Hunter Weapon List"
        mhWeaponTableView.dataSource = self
        MonsterHunterWeaponsAPIClient.getAllWeapons { (weapon, error) in
            if let weapon = weapon {
                self.monsterHunterWeapons = weapon
            }
            if let error = error {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MonsterHunterWeaponsDetailViewController,
            let cellSelected = mhWeaponTableView.indexPathForSelectedRow else { return }
            let userSelected = monsterHunterWeapons[cellSelected.row]
            destination.mhWeapon = userSelected
    }
}


extension MonsterHunterWeaponController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monsterHunterWeapons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mhWeaponTableView.dequeueReusableCell(withIdentifier: "mhWeaponCell", for: indexPath) as? MonsterHunterWeaponCell else { return UITableViewCell() }
        let weaponToSet = monsterHunterWeapons[indexPath.row]
                do {
                    let imageData = try Data(contentsOf: (weaponToSet.assets?.icon)!)
                    cell.mhWeaponImage.image = UIImage.init(data: imageData)
                } catch {
                    print("Error: \(error)")
                }
        cell.mhWeaponName.text = weaponToSet.name
        cell.layer.borderWidth = 2
        return cell
    }
    
}
