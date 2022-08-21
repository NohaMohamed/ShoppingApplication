//
//  ProductTableViewCell.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setProduct(_ product: SearchResultUIModel){
        if let url = product.productImageUrl, let imageUrl = URL(string: url){
            productImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
        }
        priceLabel.text = String(describing: product.salesPrice)
        titleLabel.text = product.productName
    }
}
