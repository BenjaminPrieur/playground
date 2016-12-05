//: [Previous](@previous)

import Foundation

enum Result<ValueType> {
	case ok(ValueType)
	case error(Error)
}

protocol Validator {
	func validate(_ value: String) -> Result<String>
}

protocol CompositeValidator: Validator {
	var validators: [Validator] { get }

	func validate(_ value: String) -> [Result<String>]
}


extension CompositeValidator {
	func validate(_ value: String) -> [Result<String>] {
		return validators.map { $0.validate(value) }
	}

	func validate(_ value: String) -> Result<String> {
		let results: [Result<String>] = validate(value)
		let errors = results.filter {
			if case .error(_) = $0 {
				return true
			}
			else {
				return false
			}
		}

		return errors.first ?? .ok(value)
	}
}

enum EmailValidationError: Error {
	case empty
	case invalidFormat
}

enum PasswordValidationError: Error {
	case empty
	case weak(reasoning: [PasswordStrengthValidationError])
}

enum PasswordStrengthValidationError: Error {
	case length
	case missingUppercase
	case missingLowercase
	case missingNumber
}

class PasswordStrengthValidator: CompositeValidator {
	let validators: [Validator]

	init() {
		self.validators = [
			PasswordLengthValidator(),
			PasswordIncludesUppercaseValidator(),
			PasswordIncludesLowercaseValidator(),
			PasswordIncludesNumbersValidator()
		]
	}

	func validate(_ value: String) -> Result<String> {
		let result = validate(value) as [Result<String>]
		let errors = result.filter { if case .error(_) = $0 { return true }; return false }

		if errors.isEmpty { return .ok(value) }

		let reasons: [PasswordStrengthValidationError] = errors.map {
			if case let .error(reason) = $0 { return reason as! PasswordStrengthValidationError }
			fatalError("This code should never be reached. It is an error if it ever hits.")
		}

		return .error(PasswordValidationError.weak(reasoning: reasons))
	}
}

class PasswordEmptyValidator: Validator {
	func validate(_ value: String) -> Result<String> {
		return value.isEmpty ? .error(PasswordValidationError.empty) : .ok(value)
	}
}

class PasswordLengthValidator: Validator {
	static let minimumPasswordLength: Int = 8

	func validate(_ value: String) -> Result<String> {
		return value.characters.count >= PasswordLengthValidator.minimumPasswordLength ?
			.ok(value) :
			.error(PasswordStrengthValidationError.length)
	}
}

class PasswordIncludesUppercaseValidator: Validator {
	func validate(_ value: String) -> Result<String> {
		return value.rangeOfCharacter(from: NSCharacterSet.uppercaseLetters) != nil ?
			.ok(value) :
			.error(PasswordStrengthValidationError.missingUppercase)
	}
}

class PasswordIncludesLowercaseValidator: Validator {
	func validate(_ value: String) -> Result<String> {
		return value.rangeOfCharacter(from: NSCharacterSet.lowercaseLetters) != nil ?
			.ok(value) :
			.error(PasswordStrengthValidationError.missingLowercase)
	}
}

class PasswordIncludesNumbersValidator: Validator {
	func validate(_ value: String) -> Result<String> {
		return value.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil ?
			.ok(value) :
			.error(PasswordStrengthValidationError.missingNumber)
	}
}

class PasswordValidator: CompositeValidator {
	let validators: [Validator]

	init() {
		self.validators = [
			PasswordEmptyValidator(),
			PasswordStrengthValidator()
		]
	}
}

class EmailEmptyValidator: Validator {
	func validate(_ value: String) -> Result<String> {
		return value.isEmpty ? .error(EmailValidationError.empty) : .ok(value)
	}
}

class EmailFormatValidator: Validator {
	func validate(_ value: String) -> Result<String> {
		let magicEmailRegexStolenFromTheInternet = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

		let emailTest = NSPredicate(format:"SELF MATCHES %@", magicEmailRegexStolenFromTheInternet)

		return emailTest.evaluate(with: value) ?
			.ok(value) :
			.error(EmailValidationError.invalidFormat)
	}
}

class EmailValidator: CompositeValidator {
	let validators: [Validator]

	init() {
		self.validators = [
			EmailEmptyValidator(),
			EmailFormatValidator()
		]
	}
}

func validate(value: String, validator: Validator) {
	print("value: \"\(value)\" => \(validator.validate(value))")
}

let emailValidator = EmailValidator()
validate(value: "", validator: emailValidator)
validate(value: "invalidEmail@", validator: emailValidator)
validate(value: "validEmail@validDomain.com", validator: emailValidator)

print("---")

let passwordValidator = PasswordValidator()
validate(value: "", validator: passwordValidator)
validate(value: "psS$", validator: passwordValidator)
validate(value: "passw0rd", validator: passwordValidator)
validate(value: "paSSw0rd", validator: passwordValidator)

//: [Next](@next)
