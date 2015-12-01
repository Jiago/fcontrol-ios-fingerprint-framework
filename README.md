# FControl iOS fingerprint framework
Swift 2.1 framework para criação de device fingerprint em aplicativos iOS para
fins de integração com o sistema de análises anti-fraude FControl.

Este framework é composto por uma classe principal **MobileDeviceFingerprint**
e nela existem os métodos que devem ser utilizados para registro e geração do
device fingerprint. Uma vez gerado, caberá ao desenvolvedor do aplicativo
realizar a integração com o serviço de análises FControl e fornecer o fingerprint
criado.

## Como usar

Para utilizar o framework existe a necessidade de se registrar o device fingerprint para posterior recuperação. Tal registro pode ser feito conforme descrito na seção a seguir.

### Registro do device fingerprint

O registro do device fingerprint deve ser feito no aplicativo usando o método ***registerUUID()*** da classe **MobileDeviceFingerprint**, conforme abaixo:

```ruby
let service = MobileDeviceFingerprint()
service.registerUUID()
```

Tal chamada deve ser feita dentro do método ***application()*** da classe **AppDelegate**, conforme descrito abaixo:

```ruby
import UIKit
import MobileDeviceFingerprint

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        let service = MobileDeviceFingerprint()
        service.registerUUID()

        return true
    }
    ...
}
```

Vale ressaltar que esta chamada deverá ser feita somente uma vez na aplicação.

### Recuperação do device fingerprint na aplicação

Uma vez feito o registro do UUID o próximo passo é a obtenção da string contendo o device fingerprint e outras informações do dispositivo do usuário. Ela pode ser obtida via chamada do método **getDeviceFingerprint()**. Segue exemplo abaixo:

```ruby
@IBAction func loadInformation(sender: AnyObject) {
  let service = MobileDeviceFingerprint()
  var df = service.getDeviceFingerprint()
  print(df)
}
```

Este método devolverá uma string em formato JSON contendo as informações do dispositivo conforme exemplo:

```json
{"plataforma":"IOS","fabricante":"Apple","deviceID":"4A46ACD3-F4EB-4B0C-85F9-E98A2AC884B1","modelo":"Simulator","operadora":"","os":"iPhone OS","osVersion":"9.1","deviceName":"iPhone Simulator","ssidWifi":"","ddd":"","telefone":"","latitude":"","longitude":""}
```

Caso o desenvolvedor queria obter os dados separadamente, existem métodos ***getXXX()*** que recuperam cada valor existente no JSON separadamente.

Uma vez recuperada a string JSON cabe ao desenvolvedor do aplicativo fazer o envio dela ao serviço de análise anti-fraude FControl.
