import Dispatch
import DispatchIntrospection
import Foundation

public func GDataGetXMLString<R>(_ str: String?, _ body: (UnsafePointer<Int>?) throws -> R?) rethrows -> R? {
    return try str?.utf8CString.withUnsafeBufferPointer({ strBuffer in
        try strBuffer.baseAddress?.withMemoryRebound(to: Int.self, capacity: str!.characters.count, { strXmlChars in
            return try body(strXmlChars)
        })
    })
}

public func tesInference() {
    let string: String? = "test"
    GDataGetXMLString(string, { defaultPrefix in
        NSLog("log")
        NSLog("log")
    })
}


public func testFoundation(){
  // Make an URLComponents instance
  let swifty = NSURLComponents(string: "https://swift.org")!
  // Print something useful about the URL
  NSLog("\(swifty.host!)")


  let filename = "/data/local/tmp/file"
  let contents = try? String(contentsOfFile: filename, encoding: .utf8)

  NSLog(contents ?? "Cannot read file \(filename)")
}

public func testSwift(){
  //: Playground - noun: a place where people can play
  NSLog("Hello, Android")

  var str = "Hello, playground"
  str = str + " concat";
  str += " smth";

  var smth: Float = 1

  let label = "The width is "
  let width = 94
  let widthLabel = label + String(width)

  let l1 = "The width is \(width)"

  let individualScores = [75, 43, 103, 87, 12]
  var teamScore = 0
  for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
  }
  NSLog("%d", teamScore)

  var optionalString: String? = "Hello"
  NSLog(optionalString == nil ? "true" : "false")

  var optionalName: String? = "John Appleseed"
  var greeting = "Hello!"
  if let name = optionalName {
    greeting = "Hello, \(name)"
  }

  let vegetable = "red pepper"
  switch vegetable {
  case "celery":
    let vegetableComment = "Add some raisins and make ants on a log."
  case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
//case let x where x.hasSuffix("pepper"):
//    let vegetableComment = "Is it a spicy \(x)?"
  default:
    let vegetableComment = "Everything tastes good in soup."
  }

  let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
  ]

  var largest = 0
  var kind: String = "unknown"
  for (key, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            kind = key
        }
    }
  }

  NSLog("%d", largest)
  NSLog(kind)

  var numbers = [20, 19, 7, 12]
  /*func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
  }
  
  func lessThanTen(number: Int) -> Bool {
    return number < 10
  }
  NSLog(hasAnyMatches(list: numbers, condition: lessThanTen))*/

  numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
  })

  numbers.map({ number in 3 * number })
}

//--------------------------------------------------------------------------------------------
class Person {
    let name: String
    init(name: String) {
        self.name = name
        NSLog("\(name) is being initialized")
    }
    var apartment: Apartment?
    deinit {
        NSLog("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { NSLog("Apartment \(unit) is being deinitialized") }
}

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { NSLog("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { NSLog("Card #\(number) is being deinitialized") }
}

class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        NSLog("\(name) is being deinitialized")
    }
}

public func testArc(){
  NSLog("ARC TEST START!")
  NSLog("ARC test1:")
  var reference1: Person?
  var reference2: Person?
  var reference3: Person?
  reference1 = Person(name: "John Appleseed")
  // Prints "John Appleseed is being initialized"
  reference2 = reference1
  reference3 = reference1
  reference1 = nil
  reference2 = nil
  reference3 = nil
  // Prints "John Appleseed is being deinitialized"

  NSLog("ARC test2:")
  var john: Person?
  var unit4A: Apartment?
  john = Person(name: "John Appleseed")
  unit4A = Apartment(unit: "4A")
  john!.apartment = unit4A
  unit4A!.tenant = john
  john = nil
  // Prints "John Appleseed is being deinitialized"
  unit4A = nil
  // Prints "Apartment 4A is being deinitialized"

  NSLog("ARC test3:")

  var steave: Customer?
  steave = Customer(name: "John Appleseed")
  steave!.card = CreditCard(number: 1234_5678_9012_3456, customer: steave!)
  steave = nil
  // Prints "John Appleseed is being deinitialized"
  // Prints "Card #1234567890123456 is being deinitialized"

  NSLog("ARC test4:")
  var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
  NSLog(paragraph!.asHTML())
  // Prints "<p>hello, world</p>"
  paragraph = nil
  // Prints "p is being deinitialized"
}

//--------------------------------------------------------------------------------------------
public func testGcd(){
  NSLog("GCD TEST START!")

  var myCustomQueue: dispatch_queue_t  = dispatch_queue_create("com.example.MyCustomQueue", nil);

  dispatch_async(myCustomQueue, {
    NSLog("Do some work here.");
  });
  NSLog("The first block may or may not have run.");

  dispatch_sync(myCustomQueue, {
    NSLog("Do some more work here.");
  });
  NSLog("Both blocks have completed.");

  // Retain the queue provided by the user to make
  // sure it does not disappear before the completion
  // block can be called.
  // dispatch_retain(queue);

  // Do the work on the default concurrent queue and then
  // call the user-provided block with the results.
  dispatch_async(dispatch_get_global_queue(Int(DISPATCH_QUEUE_PRIORITY_DEFAULT), 0), {
    dispatch_async(myCustomQueue, {
        NSLog("Hello from async");
    });
    // Release the user-provided queue when done
    //dispatch_release(queue);
  });

  var queue = dispatch_get_global_queue(Int(DISPATCH_QUEUE_PRIORITY_DEFAULT), 0);
  var group = dispatch_group_create();

  // Add a task to the group
  dispatch_group_async(group, queue, {
    // Some asynchronous work
    NSLog("testGroup before sleep");
    sleep(1);
    NSLog("testGroup after sleep");
  });

  // Do some other work while the tasks execute.
  NSLog("testGroup before wait");

  // When you cannot make any more forward progress,
  // wait on the group to block the current thread.
  dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
  NSLog("testGroup after wait");

  // Release the group when it is no longer needed.
  //dispatch_release(group);

  NSLog("testGroup after release");
}

testFoundation()
testSwift()
testArc()
testGcd()
