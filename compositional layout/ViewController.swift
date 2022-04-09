//
//  ViewController.swift
//  compositional layout
//
//  Created by hardip gajera on 09/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0:
                let item = NSCollectionLayoutSupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalWidth(0.2)))
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.contentInsets.bottom = 16
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.contentInsets.trailing = 16
                header.contentInsets.bottom = 16
                section.boundarySupplementaryItems = [header]
                return section
            case 1:
                let item = NSCollectionLayoutSupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)),subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.contentInsets.leading = 16
                header.contentInsets.trailing = 16
                header.contentInsets.bottom = 16
                section.boundarySupplementaryItems = [header]
                return section
            case 2:
                let item = NSCollectionLayoutSupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.33)))
                item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130)),subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.contentInsets.leading = 16
                header.contentInsets.trailing = 16
                header.contentInsets.bottom = 16
                section.boundarySupplementaryItems = [header]
                section.contentInsets.bottom = 16
                return section
            case 3:
                
                let firstGroupItemFirst = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
                firstGroupItemFirst.contentInsets.leading = 8
                firstGroupItemFirst.contentInsets.trailing = 8
                let firstGroupItemSecond = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1)))
                firstGroupItemSecond.contentInsets.leading = 8
                firstGroupItemSecond.contentInsets.trailing = 8
                let firstGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [firstGroupItemFirst,firstGroupItemSecond])
                firstGroup.contentInsets.top = 8
                firstGroup.contentInsets.bottom = 8
                
                let item = NSCollectionLayoutSupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(125)))
                item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                
                let lastGroupItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
                lastGroupItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
                let lastGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [lastGroupItem])
                
                let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)),subitems: [firstGroup,item,lastGroup])
                let section = NSCollectionLayoutSection(group: containerGroup)
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(66)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
                section.boundarySupplementaryItems = [header]
                return section
            default:
                fatalError()
            }
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 15
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return 30
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
            if indexPath.section == 0 {
                headerView.titleLabel.text = "  Story "
            } else if indexPath.section == 1 {
                headerView.titleLabel.text = "  Post "
            } else if indexPath.section == 2 {
                headerView.titleLabel.text = "  Feed "
            } else {
                headerView.titleLabel.text = "  Profile "
            }
            headerView.configure()
            return headerView
        default:
            fatalError()
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCell.identifier, for: indexPath)
        c.backgroundColor = .purple
        return c
    }
    
    
}


class collectionViewCell: UICollectionViewCell {
    static var identifier = "collectionViewCell"
}

class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    let titleLabel = UILabel()
    
    func configure() {
        self.backgroundColor = UIColor.systemPink
        
        titleLabel.frame = self.bounds
        titleLabel.textColor = .white
        addSubview(titleLabel)
    }
    
}
