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
    
    func setProduct(_ product: ProductUIModel){
        if let url = product.productImage, let imageUrl = URL(string: url){
            productImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
        }
        priceLabel.text = String(describing: product.productPrice)
        titleLabel.text = product.productName
    }
}
