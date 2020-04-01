# FinanceKit

[![Build Status](https://app.bitrise.io/app/e84bb055bf6392ac/status.svg?token=C_r2Pd6FmyPSuX8fJvCxcw)](https://app.bitrise.io/app/e84bb055bf6392ac) [![Swift Version](https://img.shields.io/static/v1?label=Swift&message=4.0&color=red)

FinanceKit is a Swift framework for working with financial data in your apps. It has support for Stocks, Portfolios, Holdings, Currencies, financial calculations and more.

The framework is primarily providing you with various financial data-models, and calculations.

FinanceKit is used in [Stokki](https://stokki.app), an app to manage and track your stock portfolio.

The framework is in a very early stage. Breaking changes will happen until version 1.0 is released.

## Getting Started

FinanceKit is only available using the Swift Package Manager. To install it into a project, add it as a dependency within your Package.swift manifest:
```
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/christiankm/financekit.git", from: "0.1.0")
    ],
    ...
)
```

Then import FinanceKit wherever you’d like to use it:
```
import FinanceKit
```

## Contributing and Support
Since this is a very young project, it’s likely to have many limitations and missing features, which is something that can really only be discovered and addressed as more people start using it.

If you see *any* way to improve this framework and its documentation, you are highly encouraged to submit a pull-request.

All pull requests will be checked by the CI-system on Bitrise. The CI will build the package, run all tests, and run tools like Swiftlint to verify the code style and integrity.
Pull requests can be merged after review and when these checks have passed.

Of course you're also most welcome to open an issue with your problem or question.

This project uses the standard [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).

## Authors

* [Christian Mitteldorf](https://github.com/christiankm) - [christian@mitteldorf.dk](mailto:christian@mitteldorf.dk)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/christiankm/FinanceKit/blob/master/LICENSE) file for details
