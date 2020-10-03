# [Realm](https://realm.io/)

## [CocoaPods](https://cocoapods.org/)

- pod init; open Podfile -a Xcode
    - edit Podfile to include packages
- pod install
- pod update
- open workspace

## Resources

- [Realm Mobile Database](https://www.mongodb.com/realm/mobile/database)
- [For Swift](https://realm.io/docs/swift/latest)
- [Source Code](https://github.com/realm/realm-cocoa)
- [Realm Blog](https://realm.io/blog/page/2/)


override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
    cell.delegate = self
    return cell
}


