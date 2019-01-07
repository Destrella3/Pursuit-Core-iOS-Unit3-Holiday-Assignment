import UIKit
import AVFoundation

class MonsterHunterWeaponController: UIViewController {
    
    private var monsterHunterWeapons = [MonsterHunterWeapon]() {
        didSet {
            DispatchQueue.main.async {
                self.mhWeaponTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var mhWeaponTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        mhWeaponTableView.delegate = self
        mhWeaponTableView.dataSource = self
        loadData()
    }
    func loadData() {
        mhWeaponTableView.layer.borderWidth = 2.0
        title = "Monster Hunter World Weapon List"
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
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        return cell
    }
}

extension MonsterHunterWeaponController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MonsterHunterWeaponController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text,
            !searchText.isEmpty,
            let searchTextEncoded = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return loadData()}
        monsterHunterWeapons = monsterHunterWeapons.filter{$0.name.contains(searchTextEncoded.capitalized)}
    }
}

