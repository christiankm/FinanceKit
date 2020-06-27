//
//  CurrencyCode.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 29/11/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

/// Contains all available currencies which a monetary value could be of.
/// Currencies are uniquely identified by their currency code after the ISO 4217 standard.
/// A currency code is a three-letter code that is usually composed of
/// a country’s two-character Internet country code and the currency unit.
/// For example, the currency code for the Australian dollar is “AUD”.
public enum CurrencyCode: String, Codable, CaseIterable {
    case none = "",
    afghani = "AFN",
    algerianDinar = "DZD",
    argentinePeso = "ARS",
    armenianDram = "AMD",
    arubanFlorin = "AWG",
    australianDollar = "AUD",
    azerbaijanManat = "AZN",
    bahamianDollar = "BSD",
    bahrainiDinar = "BHD",
    baht = "THB",
    balboa = "PAB",
    barbadosDollar = "BBD",
    belarusianRuble = "BYN",
    belizeDollar = "BZD",
    bermudianDollar = "BMD",
    boliviano = "BOB",
    bolívar = "VEF",
    brazilianReal = "BRL",
    bruneiDollar = "BND",
    bulgarianLev = "BGN",
    burundiFranc = "BIF",
    caboVerdeEscudo = "CVE",
    canadianDollar = "CAD",
    caymanIslandsDollar = "KYD",
    chileanPeso = "CLP",
    colombianPeso = "COP",
    comorianFranc  = "KMF",
    congoleseFranc = "CDF",
    convertibleMark = "BAM",
    cordobaOro = "NIO",
    costaRicanColon = "CRC",
    cubanPeso = "CUP",
    czechKoruna = "CZK",
    dalasi = "GMD",
    danishKrone = "DKK",
    denar = "MKD",
    djiboutiFranc = "DJF",
    dobra = "STN",
    dominicanPeso = "DOP",
    dong = "VND",
    eastCaribbeanDollar = "XCD",
    egyptianPound = "EGP",
    elSalvadorColon = "SVC",
    ethiopianBirr = "ETB",
    euro = "EUR",
    falklandIslandsPound = "FKP",
    fijiDollar = "FJD",
    forint = "HUF",
    ghanaCedi = "GHS",
    gibraltarPound = "GIP",
    gourde = "HTG",
    guarani = "PYG",
    guineanFranc = "GNF",
    guyanaDollar = "GYD",
    hongKongDollar = "HKD",
    hryvnia = "UAH",
    icelandKrona = "ISK",
    indianRupee = "INR",
    iranianRial = "IRR",
    iraqiDinar = "IQD",
    jamaicanDollar = "JMD",
    jordanianDinar = "JOD",
    kenyanShilling = "KES",
    kina = "PGK",
    kuna = "HRK",
    kuwaitiDinar = "KWD",
    kwanza = "AOA",
    kyat = "MMK",
    laoKip = "LAK",
    lari = "GEL",
    lebanesePound = "LBP",
    lek = "ALL",
    lempira = "HNL",
    leone = "SLL",
    liberianDollar = "LRD",
    libyanDinar = "LYD",
    lilangeni = "SZL",
    loti = "LSL",
    malagasyAriary = "MGA",
    malawiKwacha = "MWK",
    malaysianRinggit = "MYR",
    mauritiusRupee = "MUR",
    mexicanPeso = "MXN",
    mexicanUnidadDeInversion = "MXV",
    moldovanLeu = "MDL",
    moroccanDirham = "MAD",
    mozambiqueMetical = "MZN",
    mvdol = "BOV",
    naira = "NGN",
    nakfa = "ERN",
    namibiaDollar = "NAD",
    nepaleseRupee = "NPR",
    netherlandsAntilleanGuilder = "ANG",
    newIsraeliSheqel = "ILS",
    newTaiwanDollar = "TWD",
    newZealandDollar = "NZD",
    ngultrum =  "BTN",
    northKoreanWon = "KPW",
    norwegianKrone = "NOK",
    ouguiya = "MRU",
    paanga = "TOP",
    pakistanRupee = "PKR",
    pataca = "MOP",
    pesoConvertible = "CUC",
    pesoUruguayo = "UYU",
    philippinePiso = "PHP",
    poundSterling = "GBP",
    pula = "BWP",
    qatariRial = "QAR",
    quetzal = "GTQ",
    rand = "ZAR",
    rialOmani = "OMR",
    riel = "KHR",
    romanianLeu = "RON",
    rufiyaa = "MVR",
    rupiah = "IDR",
    russianRuble = "RUB",
    rwandaFranc = "RWF",
    saintHelenaPound = "SHP",
    saudiRiyal = "SAR",
    serbianDinar = "RSD",
    seychellesRupee = "SCR",
    singaporeDollar = "SGD",
    sol = "PEN",
    solomonIslandsDollar = "SBD",
    som = "KGS",
    somaliShilling = "SOS",
    somoni = "TJS",
    southSudanesePound = "SSP",
    sriLankaRupee = "LKR",
    sudanesePound = "SDG",
    surinamDollar = "SRD",
    swedishKrona = "SEK",
    swissFranc = "CHF",
    syrianPound = "SYP",
    taka = "BDT",
    tala = "WST",
    tanzanianShilling = "TZS",
    tenge = "KZT",
    trinidadAndTobagoDollar = "TTD",
    tugrik = "MNT",
    tunisianDinar = "TND",
    turkishLira = "TRY",
    turkmenistanNewManat = "TMT",
    uaeDirham = "AED",
    ugandaShilling = "UGX",
    unidadDeFomento = "CLF",
    unidadDeValorReal = "COU",
    unitedStatesDollar = "USD",
    uruguayPesoEnUnidadesIndexadas = "UYI",
    uzbekistanSum = "UZS",
    vatu = "VUV",
    wirEuro = "CHE",
    wirFranc = "CHW",
    won = "KRW",
    yemeniRial = "YER",
    yen = "JPY",
    yuanRenminbi = "CNY",
    zambianKwacha = "ZMW",
    zimbabweDollar = "ZWL",
    zloty = "PLN"
}
