import Foundation

// структура для записи диапазонов
struct DistanceStruct {
    let start: Int
    let end: Int
    let distance: Int
}

class CoronaClass {

    var seats = [Int]()
    var seatsTaken = [Int]()
    

    init(n: Int) {
        seatsTaken = Array(repeating: 0, count: n)
    }
    
//    func checkForBoundaries(n: Int) -> Bool {
//        if n < 1 || n > 100 {
//            return false
//        }
//        return true
//    }
    
    func seat() -> Int {
        

        var distanceArray = [DistanceStruct]()
        var startSeat = 0
        var endSeat = 0
        var startSeatFinal = 0
        var endSeatFinal = 0
        var seatDiff = 0
        var i = 0
        
        // итерируюсь по массиву и создаю диапазоны пустых мест
        while i < seatsTaken.count {
            
            //начало диапазона
            if seatsTaken[i] == 0 {
                var j = i
                startSeat = i
                endSeat = j
                
                repeat {
                    if  seatsTaken[j] == 0  && j < seatsTaken.count {
                        endSeat = j
                    }
                    else {
                        endSeat = j - 1
                    }
                    j += 1
                } while j < seatsTaken.count && seatsTaken[j] == 0
                // конец диапазона
                
                // запись в массив диапазонов
                if startSeat == 0 || endSeat == seatsTaken.count - 1 {
                    distanceArray.append(DistanceStruct(start: startSeat, end: endSeat, distance: endSeat - startSeat))
                }
                else {
                    distanceArray.append(DistanceStruct(start: startSeat, end: endSeat, distance: (endSeat - startSeat) / 2 ))
                }
            
                if endSeat == seatsTaken.count {
                   i = endSeat
                }
                else {
                   i = endSeat + 1
                }
            }
            
            if i < seatsTaken.count {
                if seatsTaken[i] != 0 {
                    i += 1
                }
            }
        }
        // сортирую массив диапазонов
        distanceArray.sort { (DistanceStruct1, DistanceStruct2) -> Bool in
            DistanceStruct1.distance > DistanceStruct2.distance
        }
        startSeatFinal = distanceArray[0].start
        endSeatFinal = distanceArray[0].end
        seatDiff = distanceArray[0].distance
        
//        print("startSeatFinal", startSeatFinal)
//        print("endSeatFinal", endSeatFinal)
//        print("seatDiff", seatDiff)
        
        var seat = 0
        
        // проверка на то что диапазон начинается с 0
        if startSeatFinal == 0 {
            seatsTaken[startSeatFinal] = 1
            seats.append(startSeatFinal)
        }
        // проверка на то что диапазон заканчивается последней партой
        else if endSeatFinal == seatsTaken.count - 1 {
            seatsTaken[endSeatFinal] = 1
            seats.append(endSeatFinal)
        }
        
        // проверка диапазона 0й длины
        else if startSeatFinal == endSeatFinal {
        seat = startSeatFinal
           seatsTaken[seat] = 1
           seats.append(seat)
        }
        else {
           seat = startSeatFinal + seatDiff
           seatsTaken[seat] = 1
           seats.append(seat)
        }
       
//        print(distanceArray)
        seats.sort()
//        print(seatsTaken)
//        print(seats)
        
       return seat
    }
    
    func leave(_ p: Int) {
        // пробегаюсь по массиву занятых мест seatsTaken, освобождаю место и удаляю из seats
        if seatsTaken[p] != 0 {
            seatsTaken[p] = 0
            var buffer: [Int] = []
            for i in seats {
                if i != p {
                    buffer.append(i)
                }
            }
            seats = buffer
            seats.sort()
        }
    }
}
