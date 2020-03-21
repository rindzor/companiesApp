//
//  TableViewCell1.swift
//  CompaniesInTable
//
//  Created by  mac on 3/18/20.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class TableViewCell1: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var gifView: UIImageView!
    var animated = false
    

    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = 15
        gifView.layer.cornerRadius = 15
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func load(with urlString: String) {
        gifView.image = nil
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: urlString as String) else {
                return
            }
            guard let data = try? Data(contentsOf: url) else {
                return
            }

            DispatchQueue.main.async {
                self?.gifView.image = UIImage.gif(data: data)
            }
        }
    }
    
}
