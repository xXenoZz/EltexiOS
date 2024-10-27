//
//  ViewController.swift
//  Add_order_price
//
//  Created by Мак on 16.10.2024.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupSeparatorView()
        setupPromocodeInfo()
        setupApplyPromoButton()
        setupPromocodeStack()
        setupHidePromoButton()
        setupFooterView()
        updatePriceLabels()
    }
    
    var order: Order = Order(screenTitle: "Заказ 654", promocodes: [
        Order.Promocode(title: "Promo2024", percent: 16, endDate: Date(timeIntervalSince1970: 1732902300), info: "Только для новых пользователей", active: false),
        Order.Promocode(title: "AUTUMN24", percent: 24, endDate: Date(timeIntervalSince1970: 1732047300), info: "Встречаем осень вместе со скидками!", active: false),
        Order.Promocode(title: "EVERYDAILY", percent: 5, endDate: nil, info: "Пользуйтесь в любой день!", active: false),
        Order.Promocode(title: "BIGSALE", percent: 30, endDate: Date(timeIntervalSinceNow: 87000), info: "Не упустите крупную акцию!", active: false)
    ], products: [
        Order.Product(price: 10000, title: "Iphone 16 pro max"),
        Order.Product(price: 25000, title: "Oculus quest 3")
    ], paymentDiscount: 2700.0, baseDiscount: 10000.0)
    
    
    let headerLabel = UILabel()
    private func setupHeaderView() {
        headerLabel.text = "Оформление заказа"
        headerLabel.font = UIFont.systemFont(ofSize: 14)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    let separatorView = UIView()
    private func setupSeparatorView() {
        separatorView.backgroundColor = UIColor(hex: "#F6F6F6")
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    let promocodeTitleLabel = UILabel()
    let promocodeInfoLabel = UILabel()
    private func setupPromocodeInfo() {
        promocodeTitleLabel.text = "Промокоды"
        promocodeTitleLabel.font = UIFont.systemFont(ofSize: 27)
        promocodeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(promocodeTitleLabel)
        
        NSLayoutConstraint.activate([
            promocodeTitleLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 7),
            promocodeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        promocodeInfoLabel.text = "На один товар можно применить только один промокод."
        promocodeInfoLabel.font = UIFont.systemFont(ofSize: 12)
        promocodeInfoLabel.textColor = .darkGray
        promocodeInfoLabel.numberOfLines = 0
        promocodeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(promocodeInfoLabel)
        
        NSLayoutConstraint.activate([
            promocodeInfoLabel.topAnchor.constraint(equalTo: promocodeTitleLabel.bottomAnchor, constant: 5),
            promocodeInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promocodeInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func applyPromoCode() {}
    
    let applyPromoButton = UIButton(type: .system)
    private func setupApplyPromoButton() {
        applyPromoButton.setTitle("  Применить промокод", for: .normal)
        applyPromoButton.setImage(UIImage(named: "ticketShape"), for: .normal)
        applyPromoButton.tintColor = UIColor(hex: "#FF4611")
        applyPromoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        applyPromoButton.backgroundColor = UIColor(hex: "#FFEBE6")
        applyPromoButton.layer.cornerRadius = 15
        applyPromoButton.translatesAutoresizingMaskIntoConstraints = false
        applyPromoButton.addTarget(self, action: #selector(applyPromoCode), for: .touchUpInside)
        view.addSubview(applyPromoButton)
        
        NSLayoutConstraint.activate([
            applyPromoButton.topAnchor.constraint(equalTo: promocodeInfoLabel.bottomAnchor, constant: 13),
            applyPromoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyPromoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            applyPromoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            applyPromoButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private let promocodeStackView = UIStackView()
    private func setupPromocodeStack() {
        promocodeStackView.backgroundColor = .white
        promocodeStackView.axis = .vertical
        promocodeStackView.spacing = 13
        promocodeStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(promocodeStackView)
        
        NSLayoutConstraint.activate([
            promocodeStackView.topAnchor.constraint(equalTo: applyPromoButton.bottomAnchor, constant: 13),
            promocodeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promocodeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        for promocode in order.promocodes {
            addPromocode(promocode)
        }
    }

    func addPromocode(_ promocode: Order.Promocode) {
        let promocodeView = UIView()
        promocodeView.backgroundColor = UIColor(hex: "#F6F6F6")
        promocodeView.layer.cornerRadius = 15
        promocodeView.heightAnchor.constraint(equalToConstant: 84).isActive = true
        promocodeView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = promocode.title
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        promocodeView.addSubview(titleLabel)
        
        let discountLabel = UILabel()
        discountLabel.text = " \(promocode.percent)%  "
        discountLabel.font = UIFont.systemFont(ofSize: 16)
        discountLabel.backgroundColor = UIColor(hex: "#00B775")
        discountLabel.textColor = .white
        discountLabel.layer.cornerRadius = 10
        discountLabel.clipsToBounds = true
        discountLabel.textAlignment = .center
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        promocodeView.addSubview(discountLabel)
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.tintColor = .gray
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        promocodeView.addSubview(infoButton)
        
        let expirationLabel = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: promocode.endDate ?? Date(timeIntervalSinceNow: 999999999))
        expirationLabel.text = "Срок действия: \(formattedDate)"
        expirationLabel.font = UIFont.systemFont(ofSize: 12)
        expirationLabel.translatesAutoresizingMaskIntoConstraints = false
        promocodeView.addSubview(expirationLabel)
        
        let infoLabel = UILabel()
        infoLabel.text = promocode.info ?? ""
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.numberOfLines = 1
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        promocodeView.addSubview(infoLabel)
        
        let circleLeft = UIView()
        circleLeft.backgroundColor = .white
        circleLeft.layer.cornerRadius = 10
        circleLeft.translatesAutoresizingMaskIntoConstraints = false
        promocodeView.addSubview(circleLeft)
        
        let circleRight = UIView()
        circleRight.backgroundColor = .white
        circleRight.layer.cornerRadius = 10
        circleRight.translatesAutoresizingMaskIntoConstraints = false
        promocodeView.addSubview(circleRight)
        
        let activeSwitch = UISwitch()
        activeSwitch.isOn = promocode.active
        activeSwitch.onTintColor = UIColor(hex: "#FF4611")
        activeSwitch.translatesAutoresizingMaskIntoConstraints = false
        activeSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        promocodeView.addSubview(activeSwitch)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: promocodeView.topAnchor, constant: 11),
            titleLabel.leadingAnchor.constraint(equalTo: promocodeView.leadingAnchor, constant: 22),
            
            discountLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            discountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            
            infoButton.leadingAnchor.constraint(equalTo: discountLabel.trailingAnchor, constant: 5),
            infoButton.centerYAnchor.constraint(equalTo: discountLabel.centerYAnchor),
            
            expirationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            expirationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            activeSwitch.centerYAnchor.constraint(equalTo: promocodeView.centerYAnchor, constant: -10),
            activeSwitch.trailingAnchor.constraint(equalTo: promocodeView.trailingAnchor, constant: -28),
            
            circleLeft.heightAnchor.constraint(equalToConstant: 20),
            circleLeft.widthAnchor.constraint(equalToConstant: 20),
            circleLeft.centerYAnchor.constraint(equalTo: promocodeView.centerYAnchor),
            circleLeft.leadingAnchor.constraint(equalTo: promocodeView.leadingAnchor, constant: -10),
            
            circleRight.heightAnchor.constraint(equalToConstant: 20),
            circleRight.widthAnchor.constraint(equalToConstant: 20),
            circleRight.centerYAnchor.constraint(equalTo: promocodeView.centerYAnchor),
            circleRight.trailingAnchor.constraint(equalTo: promocodeView.trailingAnchor, constant: 10),
            
            infoLabel.topAnchor.constraint(equalTo: expirationLabel.bottomAnchor, constant: 5),
            infoLabel.trailingAnchor.constraint(equalTo: promocodeView.trailingAnchor, constant: -20),
            infoLabel.leadingAnchor.constraint(equalTo: expirationLabel.leadingAnchor)
        ])
        promocodeStackView.addArrangedSubview(promocodeView)
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        if let index = promocodeStackView.arrangedSubviews.firstIndex(where: { ($0.subviews.last as? UISwitch) == sender }) {
            let isActive = sender.isOn
            let activeCount = order.promocodes.filter { $0.active }.count
            if isActive && activeCount >= 2 {
                if let firstActiveIndex = order.promocodes.firstIndex(where: { $0.active }) {
                    order.promocodes[firstActiveIndex].active = false
                        if let switchView = promocodeStackView.arrangedSubviews[firstActiveIndex].subviews.last as? UISwitch {
                        switchView.setOn(false, animated: true)
                    }
                }
            }
            order.promocodes[index].active = sender.isOn
            updatePriceLabels()
        }
    }
    
    let hidePromoButton = UIButton(type: .system)
    private func setupHidePromoButton() {
        hidePromoButton.setTitle("Скрыть промокоды", for: .normal)
        hidePromoButton.setTitleColor(UIColor(hex: "#FF4611"), for: .normal)
        hidePromoButton.translatesAutoresizingMaskIntoConstraints = false
        hidePromoButton.addTarget(self, action: #selector(hidePromocodes), for: .touchUpInside)
        view.addSubview(hidePromoButton)
        
        NSLayoutConstraint.activate([
            hidePromoButton.topAnchor.constraint(equalTo: promocodeStackView.bottomAnchor, constant: 5),
            hidePromoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35)
        ])
    }
    
    @objc private func hidePromocodes() {}

    private let footerView = UIView()
    private let totalPriceLabel = UILabel()
    private let discountLabel = UILabel()
    private let promocodeDiscountLabel = UILabel()
    private let paymentDiscountLabel = UILabel()
    private let finalPriceLabel = UILabel()
    
    private func setupFooterView() {
        footerView.backgroundColor = UIColor(hex: "#F6F6F6")
        footerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(footerView)
        
        let priceTitleLabel = UILabel()
        priceTitleLabel.text = "Цена за товары"
        priceTitleLabel.font = UIFont.systemFont(ofSize: 14)
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(priceTitleLabel)
        totalPriceLabel.font = UIFont.systemFont(ofSize: 14)
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(totalPriceLabel)
        
        let discountTitleLabel = UILabel()
        discountTitleLabel.text = "Скидка"
        discountTitleLabel.font = UIFont.systemFont(ofSize: 14)
        discountTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(discountTitleLabel)
        discountLabel.font = UIFont.systemFont(ofSize: 14)
        discountLabel.textColor = UIColor(hex: "#FF4611")
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(discountLabel)
        
        let promocodeDiscountTitleLabel = UILabel()
        promocodeDiscountTitleLabel.text = "Промокоды"
        promocodeDiscountTitleLabel.font = UIFont.systemFont(ofSize: 14)
        promocodeDiscountTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(promocodeDiscountTitleLabel)
        promocodeDiscountLabel.font = UIFont.systemFont(ofSize: 14)
        promocodeDiscountLabel.textColor = UIColor(hex: "#00B775")
        promocodeDiscountLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(promocodeDiscountLabel)
        let infoButton = UIButton(type: .infoLight)
        infoButton.tintColor = .gray
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(infoButton)
        
        let paymentDiscountTitleLabel = UILabel()
        paymentDiscountTitleLabel.text = "Способ оплаты"
        paymentDiscountTitleLabel.font = UIFont.systemFont(ofSize: 14)
        paymentDiscountTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(paymentDiscountTitleLabel)
        paymentDiscountLabel.font = UIFont.systemFont(ofSize: 14)
        paymentDiscountLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(paymentDiscountLabel)
        
        let priceSeparatorView = UIView()
        priceSeparatorView.backgroundColor = .gray
        priceSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(priceSeparatorView)

        let finalPriceTitleLabel = UILabel()
        finalPriceTitleLabel.text = "Итого"
        finalPriceTitleLabel.font = UIFont.systemFont(ofSize: 20)
        finalPriceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(finalPriceTitleLabel)
        finalPriceLabel.font = UIFont.systemFont(ofSize: 20)
        finalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(finalPriceLabel)

        let orderButton = UIButton(type: .system)
        orderButton.setTitle("Оформить заказ", for: .normal)
        orderButton.setTitleColor(.white, for: .normal)
        orderButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        orderButton.backgroundColor = UIColor(hex: "#FF4611")
        orderButton.layer.cornerRadius = 15
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.addTarget(self, action: #selector(validateOrder), for: .touchUpInside)
        footerView.addSubview(orderButton)
        
        
        let legalsLabel = UILabel()
        let attrs = NSMutableAttributedString(string: "Нажимая на кнопку «Оформить заказ», Вы соглашаетесь с ", attributes: [.foregroundColor: UIColor.gray])
        attrs.append(NSMutableAttributedString(string: "Условиями оферты", attributes: [.foregroundColor: UIColor.black]))
        legalsLabel.attributedText = attrs
        legalsLabel.numberOfLines = 0
        legalsLabel.lineBreakMode = .byWordWrapping
        legalsLabel.widthAnchor.constraint(equalToConstant: 290).isActive = true
        legalsLabel.font = UIFont.systemFont(ofSize: 12)
        legalsLabel.textAlignment = .center
        legalsLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(legalsLabel)

        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: hidePromoButton.bottomAnchor, constant: 13),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            priceTitleLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 15),
            priceTitleLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 30),
            
            totalPriceLabel.topAnchor.constraint(equalTo: priceTitleLabel.topAnchor),
            totalPriceLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            
            discountTitleLabel.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 15),
            discountTitleLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor),
            
            discountLabel.topAnchor.constraint(equalTo: discountTitleLabel.topAnchor),
            discountLabel.trailingAnchor.constraint(equalTo: totalPriceLabel.trailingAnchor),
            
            promocodeDiscountTitleLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 15),
            promocodeDiscountTitleLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor),
            
            infoButton.centerYAnchor.constraint(equalTo: promocodeDiscountTitleLabel.centerYAnchor),
            infoButton.leadingAnchor.constraint(equalTo: promocodeDiscountTitleLabel.trailingAnchor, constant: 5),
            
            promocodeDiscountLabel.topAnchor.constraint(equalTo: promocodeDiscountTitleLabel.topAnchor),
            promocodeDiscountLabel.trailingAnchor.constraint(equalTo: totalPriceLabel.trailingAnchor),
            
            paymentDiscountTitleLabel.topAnchor.constraint(equalTo: promocodeDiscountLabel.bottomAnchor, constant: 15),
            paymentDiscountTitleLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor),
            
            paymentDiscountLabel.topAnchor.constraint(equalTo: paymentDiscountTitleLabel.topAnchor),
            paymentDiscountLabel.trailingAnchor.constraint(equalTo: totalPriceLabel.trailingAnchor),
            
            priceSeparatorView.topAnchor.constraint(equalTo: paymentDiscountLabel.bottomAnchor, constant: 13),
            priceSeparatorView.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor),
            priceSeparatorView.trailingAnchor.constraint(equalTo: totalPriceLabel.trailingAnchor),
            priceSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            
            finalPriceTitleLabel.topAnchor.constraint(equalTo: priceSeparatorView.bottomAnchor, constant: 12),
            finalPriceTitleLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor),
            finalPriceLabel.topAnchor.constraint(equalTo: finalPriceTitleLabel.topAnchor),
            finalPriceLabel.trailingAnchor.constraint(equalTo: totalPriceLabel.trailingAnchor),
            
            orderButton.topAnchor.constraint(equalTo: finalPriceLabel.bottomAnchor, constant: 11),
            orderButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 40),
            orderButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -40),
            orderButton.heightAnchor.constraint(equalToConstant: 55),
            
            legalsLabel.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: 7),
            legalsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func updatePriceLabels() {
        let total = order.products.reduce(0) { $0 + $1.price }
        let promocodeDiscount = order.promocodes.filter { $0.active }.reduce(0) { ($0 + ((Double($1.percent) / 100.0 * total))).rounded() }
        let finalPrice = total - (order.baseDiscount ?? 0.0) - (order.paymentDiscount ?? 0.0) - promocodeDiscount
        totalPriceLabel.text = "\(total) ₽"
        discountLabel.text = "-\(order.baseDiscount ?? 0.0) ₽"
        promocodeDiscountLabel.text = "-\(promocodeDiscount) ₽"
        paymentDiscountLabel.text = "-\(order.paymentDiscount ?? 0.0) ₽"
        finalPriceLabel.text = "\(finalPrice) ₽"
    }

    @objc private func validateOrder() { }
}

struct Order {
    struct Promocode {
        let title: String
        let percent: Int
        let endDate: Date?
        let info: String?
        var active: Bool
    }

    struct Product {
        let price: Double
        let title: String
    }
    
    var screenTitle: String
    var promocodes: [Promocode]
    let products: [Product]
    let paymentDiscount: Double?
    let baseDiscount: Double?
}

extension UIColor {
    convenience init(hex: String) {
        let r, g, b: CGFloat
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        
        var rgb: UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgb)
        
        r = CGFloat((rgb >> 16) & 0xFF) / 255
        g = CGFloat((rgb >> 8) & 0xFF) / 255
        b = CGFloat(rgb & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

extension UILabel {
    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false) {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        if (bolAfterLabel) {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)

            self.attributedText = strLabelText
        } else {
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }

    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}
