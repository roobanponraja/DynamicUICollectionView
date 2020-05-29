//
//  CollectionCell.swift
//  DynamicUICollectionView
//
//  Created by Ponraj, Rooban (Rooban Abraham) on 28/05/20.
//  Copyright © 2020 Rooban Abraham. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    //CTA Stack View
    @IBOutlet weak var ctaStackView: UIStackView!
    @IBOutlet weak var statementBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    // Whole Content - Parent
    @IBOutlet weak var accountContent: UIView!
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    
    // Note: must be strong
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            maxWidthConstraint.isActive = false
        }
    }
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        statementBtn.createDynamicButton()
        moreBtn.createDynamicButton()
        
        accountContent.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    override func updateConstraints() {
        
        let largerContentSizes = [UIContentSizeCategory.extraLarge, UIContentSizeCategory.extraExtraLarge, UIContentSizeCategory.extraExtraExtraLarge, UIContentSizeCategory.accessibilityMedium, UIContentSizeCategory.accessibilityLarge, UIContentSizeCategory.accessibilityExtraLarge, UIContentSizeCategory.accessibilityExtraExtraLarge, UIContentSizeCategory.accessibilityExtraExtraExtraLarge]
        let userContentSize = UIApplication.shared.preferredContentSizeCategory
        
        if largerContentSizes.contains(userContentSize) {
            // Large
             ctaStackView.axis = .vertical
        } else {
            //Normal
            ctaStackView.axis = .horizontal
        }

        super.updateConstraints()
    }
}

extension UIButton {
    func createDynamicButton () {
        self.titleLabel!.adjustsFontForContentSizeCategory = true
        self.titleLabel!.tintColor = UIColor.systemBlue
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
}
