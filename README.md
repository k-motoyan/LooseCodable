#  LooseCodable

LooseCodable is an extended type of Codable that performs loose type conversion.

## Example

There is a `User` type that conforms to the as following `Codable` protocol.

```swift
struct User: Codable {
    let name: String
    let age: Int
}
```

However, JSON which can not be mapped to `User` is sometimes delivered.

```json
{
    "name": "Tom",
    "age": "18"
}
```

This is an error in `Codable` as follows.  
`"Expected to decode Int but found a string/data instead."`

You can avoid such problems by using `LooseCodable`.

For example, `User` is rewritten as follows...

```swift
import LooseCodable

struct User: Codable {
    let name: String

    // Wrap the type of property that may receive unintended data in `LooseCodable`.
    private let _age: LooseCodable<Int>

    // public type is not changed.
    var age: Int {
        return self._age.value
    }

    enum CodingKeys: String, CodingKey {
        case name
        case _age = "age"
    }
}
```

You can also map to `User` with problematic JSON.

## Active types

`LooseCodable` corresponds to the following types.

* Bool
* Int
* Double
* String

## License

Alamofire is released under the BSD 3-Clause license.
