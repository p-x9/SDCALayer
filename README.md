# SDCALayer

Server-Driven CALayer

## Demo
![demo](https://user-images.githubusercontent.com/50244599/203554672-2dc2de2a-0f65-4921-8b93-ab7bf87775d6.gif)


## Document
### Supported Layer
- CALayer
- CAShapeLayer
- CATextLayer
- CAScrollLayer
- CAGradientLayer

### JSON to CALayer
```swift
let json: String = ""

let model = SDCALayer.load(fromJSON: json)

let layer: CALayer = model?.convertToLayer()
```

### YAML to CALayer
```swift
let model = SDCALayer.load(fromYAML: yaml)
```

### CALayer to JSON
```swift
let layer = CAShapeLayer()
/* ~ customize layer  ~ */

let model = SDCALayer(model: layer.codable())

let json: String = model?.json
```
### CALayer to YAML
```swift
let yaml: String = model?.yaml
```

### Formats of Layer Model 
Layer's models are defined in the following directory.
[Models](./Sources/SDCALayer/Model/)
```json
{
    "frame": [
        [
            0,
            0
        ],
        [
            100,
            50
        ]
    ],
    "cornerRadius": 5.0,
    "borderColor": {
        "code": "#FF0088"
    },
    // other properties
}
```

Since we need to know the actual class of the Layer, we need to receive a model with the class name and a model for each class, as follows
```json
{
    "class": "CAShapeLayer",
    "layerModel": {
        // CAShapeLayer Model
    }
}
```

By using the [p-x9/IndirectlyCodable](https://github.com/p-x9/IndirectlyCodable) library, CALayer indirectly conforms to the `Codable` protocol, allowing inter-conversion with json.

#### Support for custom layer classes
Suppose we have the following customized layer class.
```swift
class AALayer: CALayer {
    var newProperty: String? = "AAAA"
}
```

create layer model like this.
<details>
<summary>click to expand</summary>

```swift
class JAALayer: JCALayer {
    typealias Target = AALayer // alias for target layer class

    // Coding key (codable)
    private enum CodingKeys: String, CodingKey {
        case newProperty
    }

    // Target class name to exact layer class
    // You must specify the class name including the product name and package name.
    // (ex. MyApp.AALayer)
    public override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    override init() {
        super.init()
    }

    // Decodable
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        newProperty = try container.decodeIfPresent(String.self, forKey: .newProperty)
    }

    public required convenience init(with object: CALayer) {
        self.init()

        reverseApplyProperties(with: object)
    }

    // Encodable
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(newProperty, forKey: .newProperty)
    }

    // apply properties to taget from model
    // model -> target
    public override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? AALayer else { return }

        target.newProperty = newProperty
    }

    // apply properties to model from target
    // targe -> model
    public override func reverseApplyProperties(with target: CALayer) {
        super.reverseApplyProperties(with: target)

        guard let target = target as? AALayer else { return }

        newProperty = target.newProperty
    }

    public override func convertToLayer() -> CALayer? {
        let layer = AALayer()

        self.applyProperties(to: layer)

        return layer
    }
}
```
</summary>
</details>

## Example
### Websocket HotReload
Start the server, change the json, save it, and it will be reflected in the app.
install [calayer-ws app](./Example/calayer-ws/) to yor iphone (or simulator) and connect your server.
|  A  |  B  |
| ---- | ---- |
|  ![A](https://user-images.githubusercontent.com/50244599/203506188-cf3bd4a0-3c5e-451c-9f0b-fdd99e1caadd.PNG)  |  ![B](https://user-images.githubusercontent.com/50244599/203506216-25f25871-f0a0-410b-b918-7b687e373ecc.PNG)  |

```sh
python ./server/ws-hotreload-server.py "<path to json>"
```
example json file is [here](./Example/json/).

```sh
python ./server/ws-hotreload-server.py "./Example/json/star.json"
```
## Licenses

[MIT License](./LICENSE)
