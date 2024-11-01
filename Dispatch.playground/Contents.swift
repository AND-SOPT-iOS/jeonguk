

/*
 Dispatch란 어떤 메서드를 호출할 것인지를 결정하여, 그것을 실행하는 메커니즘이다
 Swift에선 Static Dispatch와 Dynamic Dispatch 두 가지 방식이 있다
 Dispatch라는 것은 내가 호출할 함수를 "컴파일 타임"에 결정하냐, "런타임"에 결정하냐에 따른 방식
 
 1-1. Static Dispatch (Direct Call)
 "컴파일 타임"에 호출될 함수를 결정하여, 런타임 때 그대로 실행한다
  컴파일 타임에 결정이 나기 때문에 성능상 이점을 가질 수 있다
 
 1-2. Dynamic Dispatch (Indirect Call)
 "런타임"에 호출될 함수를 결정한다
  때문에 Swift에서는 클래스마다 함수 포인터들의 배열인 vTable(Virtual Methon Table)이라는 것을 유지한다
  ex 하위 클래스가 메서드를 호출할 때, 이 vTable 를 참조하여 실제 호출할 함수를 결정한다
     이 과정들이 "런타임"에 일어나기 때문에 성능상 손해를 보게 된다
 
 정리
 Static Dispatch는 컴파일 시점에 함수를 결정해서 성능상 이점이 있고,
 Dynamic Dispatch는 런타임 시점에 함수를 결정해서 성능상 손해가 있음
 
 Dynamic Dispatch 사용하는 대표적인 타입 Reference Type, Value Type, Protocol
 
 먼저 Class 부터 살펴보자
 Reference Type의 Class는 상속의 가능성이 있다
 따라서, 서브 클래스에서 함수를 호출할 수 있기 때문에, Dynamic Dispatch를 사용한다
 그 이유가 상속 즉, "오버라이딩"의 가능성이 있기 때문임

 */
import UIKit


class SOPT_iOS {
    func sayHello() {
        print("안녕 iOS")
    }
}
 
class OB: SOPT_iOS { }

let 송여경 : SOPT_iOS = OB()
송여경.sayHello() // 💁 이때는 문제가 되지 않음 왜냐? sayHello는 오버라이딩 되지 않았기 때문!!

 
class OB2: SOPT_iOS {
   override func sayHello() {
        print("Hello OB!")
    }
}

let 이수민: SOPT_iOS = OB2()
이수민.sayHello()
/* 타입은 SOPT_iOS 이지만 OB2에서 하위 클래스에서 오버라이딩이 될 경우를 대비해, 상위 클래스의 sayHello를 참조해야 하는지,
하위 클래스의 sayHello를 참조해야 하는지를 확인하는 작업을 해야함 언제? 런타임에!!
 sayHello라는 함수는 각 클래스마다 가지고 있는 vTable이란 것 안에 함수 포인터로 두고,
 실제 런타임 시점에 이 vTable을 사용하여 어떤 메서드가 불리는지를 결정해버리는 것임
 물론 첫 번째 예제처럼 sayHello가 아무 곳에서도 오버라이딩 되지 않을 수도 있지만,
 어찌 됐건 클래스는 오버라이딩이 될 수 있다는 "가능성"이 있기 때문에
 실제 오버라이딩이 된지 안 된지는 따지지 않고 무조건 vTable을 확인해서 참조함
 
 이처럼, 런타임 과정에 해당 클래스의 vTable에서 함수를 찾아 메모리 주소를 "읽고",
 그 주소로 "점프"해야 하기 때문에 두 개의 추가 명령이 필요해서 성능상 손해를 보는 것임!
 위에서 그럼 성능 안 나오는 Dynamic Dispatch는 왜 쓰나?? 란 생각이 들 수 있는데,
 OOP에서, 오버라이딩을 하기 위해서 Dynamic Dispatch는 필수적
*/



// MARK: - 2-2. Value Type에서의 Dispatch
// Value Type인 구조체, 열거형은 상속을 할 수 없다는 특징 때문에 오버라이딩이 될 가능성이 없고, 따라서 Static Dispatch를 사용한다
// 구조체의 경우 어디서 sayHello란 함수를 불러도,늘 Human이란 구조체 안의 함수가 불릴 것이 보장되기 때문에 런타임에 따로 추적할 필요가 없어서 컴파일 타임에 결정이 되는 것!!!
struct SOPT_iOS_Struct {
    func sayHello() {
        print("Hello Human!")
    }
}



// MARK: - 2-3. Protocol에서의 Dispatch
// 프로토콜은 기본적으로 메서드의 선언부만 제공하기 때문에, 실제 사용할 때 프로토콜 타입을 참조로만 사용할 경우,
// 해당 인스턴스 타입에 맞는 메서드를 호출해야 해서 Dynamic Dispatch를 사용한다

protocol Human {
    func description()
}

struct Teacher: Human {
    func description() {
        print("I'm a teacher")
    }
}

struct Student: Human {
    func description() {
        print("I'm a student")
    }
}

let people: [Human] = [Teacher(), Student()]
for person in people {
   person.description() // 어떤 인스턴스의 description을 호출할지 런타임에 결정
}

/*
Teacher와 Student 구조체는 Human 프로토콜을 채택하고, description() 메서드를 각각 구현했어요. 이제 Human 프로토콜 타입으로 사용해 볼게요.
위 코드에서 people 배열은 Human 프로토콜 타입으로 선언되었습니다. 그래서 person.description()을 호출할 때 Swift는 Teacher인지 Student인지 런타임에 확인해야 하고, 이 때문에 동적 디스패치가 발생해요.
즉, 프로토콜 타입으로 선언된 인스턴스는 실제 타입에 따라 메서드를 호출해야 하므로, 런타임에 메서드를 찾아가는 과정이 필요한 거예요.
*/



// MARK: - 심화 Value Type, Reference Type, Protocol을 확장(extension)할 경우, 어떤 Dispatch가 사용되는지
// 1. Value Type "확장(exension)"에서의 Dispatch
// 상속의 가능성이 없기 때문에, 확장(exension)을 해도 Static Dispatch로 동작한다
struct YB {
    func sayHello() {
        print("Hello YB!")
    }
}
 
extension YB {
    func sayHo() {
        print("양꼬치 먹고 싶다~~")
    }
}
 
let 정정욱: YB = .init()
정정욱.sayHello()           // Static Dispatch
정정욱.sayHo()              // Static Dispatch

// 2. Reference Type "확장(exension)"에서의 Dispatch ⭐️
// Class를 확장(extension)하여 메서드를 추가한 경우, 서브 클래스에서 오버라이딩이 불가

/*
class Human {
    func sayHello() {
        print("Hello Human!")
    }
}
 
extension Human {
    func sayHo() {
        print("Ho~~")
    }
}
 
class Teacher: Human {
    override func sayHo() {         // error! Overriding non-@objc declarations from extensions is not supported
        
    }
}
 
 @objc를 붙여주면 오버라이딩이 가능해지긴 함!!
 (Objective-C의 런타임의 힘🔥을 빌리는 것)
 let sodeul: Human = .init()
 sodeul.sayHello()           // Dynaimc Dispatch
 sodeul.sayHo()              // Static Dispatch
*/
