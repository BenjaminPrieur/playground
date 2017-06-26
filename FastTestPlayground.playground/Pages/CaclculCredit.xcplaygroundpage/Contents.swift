//: [Previous](@previous)

import Foundation

extension Double {
	var string: String {
		return String(format: "%.02f", self)
	}
}

// Capital * ( interet / (1 - (1+interet)-nombreDeMois)

struct CreditCalculator {

	func amortissement(credit: Credit) {
		if	credit.capital > 0 {
			let interet = credit.capital * credit.txPer
			let mensualite = credit.capital * (credit.txPer / (1 - pow(1 + credit.txPer, Double(-credit.nbMonth)))) + credit.assurance
			let amort = mensualite - interet - credit.assurance
			let newCapital = max(0, credit.capital - amort)

			print("\(credit.nbMonth) Base: \(credit.capital.string)" +
				"\t- interet: \(interet.string)" +
				"\t- assurance: \(credit.assurance.string)" +
				"\t- mensualite: \(mensualite.string)" +
				"\t- amortissement: \(amort.string)" +
				"\t- new capital: \(newCapital.string)")

			let newCredit = Credit(capital: newCapital, txAn: credit.txAn, nbMonth: credit.nbMonth-1, txAssurance: credit.txAssurance, assurance: credit.assurance)
			amortissement(credit: newCredit)
		}
	}
}

struct Credit {

	let capital: Double
	let txAn: Double
	let nbMonth: Int

	let echAn: Double = 12
	let txPer: Double

	let txAssurance: Double
	let assurance: Double

	init(capital: Double, txAn: Double, nbAn: Int, txAssurance: Double) {
		self.init(capital: capital, txAn: txAn, nbMonth: nbAn * 12, txAssurance: txAssurance)
	}

	init(capital: Double, txAn: Double, nbMonth: Int, txAssurance: Double, assurance: Double? = nil) {
		self.capital = capital
		self.txAn = txAn
		self.nbMonth = nbMonth
		self.txPer = txAn / echAn
		self.txAssurance = txAssurance
		self.assurance = assurance ?? capital * (txAssurance/12)
	}
}

let credit = Credit(capital: 500_000, txAn: 0.015, nbAn: 20, txAssurance: 0.0036)
CreditCalculator().amortissement(credit: credit)

//: [Next](@next)
