//
//  Constants.swift
//  ChinaShop
//
//  Created by Roman Trekhlebov on 05.12.2017.
//  Copyright © 2017 Arseniy Arseniev. All rights reserved.
//

import Foundation

//URL Constants
let BASE_URL = "https://sushiserver.herokuapp.com/"
let URL_SPECIALS = "\(BASE_URL)specials"
let URL_ITEMS = "\(BASE_URL)items"
let URL_ORDERS = "\(BASE_URL)orders"

//Segues
let TO_BASKET_SEGUAE = "basketSegue"
let TO_ORDER_SEGUAE = "toOrderSeguae"


/*
 https://sushiserver.herokuapp.com/
 
 Проверьте, что все, в особенности девелоперы, могут сюда попасть.
 
 С кнопкой Clean Items осторожно. Реально всё удалит. надо будет заново меню перезаливать)
 
 Эндпоинт для запроса меню: /items
 
 Каждый пункт меню - это такой объект.
 {
 "_id":"5a1bb38f71a58c0014925501",
 "name":"Sake maki",
 "itemId":"220VC2",
 "description":"salmon",
 "price":"22 RMB",
 "imageUrl":"/assets/images/uploads/220VC2.jpeg"
 }
 
 Поле itemId понадобится для отправки заказа.
 
 Эндпоинт для заказа: POST в /orders
 
 JSON засылать такой:
 {
 "order": [
 {
 "id": "Z1KukSj",
 "amount": 3
 }
 ],
 "name": "Alex",
 "address": "Minsk Nezaleznasti 1",
 "phone": "375 23 1234567"
 }
 
 В поле order собственно заказ: айдишник это itemId из меню
 
 Ответ такой:
 {
 "status": "success",
 "data": {
 "orderId": "Z1XlDkP"
 }
 }
 
 Ну и сами заказы пожно посмотреть в GET /orders
 
 Я ещё добавлю эндпоинт для акций /specials
 Формат JSONа будет такой же как и у меню, только без цены. Можете стабать пока так.
 */
