
/*
 Swift is a lovely-looking language, but I really don't like how it doesn't
 let you slice strings by grapheme and makes you create and pass in
 un-ergonomic index types instead...
 I recognize that unicode has a bunch of different sizes of strings, which
 is why Swift doesn't wanna do that.  But for small strings, which are the
 kind where one might reasonably want to do a lot of Python-style slicing,
 the perf cost of just iterating to get slices all the time seems, to me, 
 to be at least sometimes outweighed by the ergonomics on the code-writing 
 side.
 So here's some slicing, by force. I'm just monkey-patching String here,
 basically.
 */

var s = "here is a boring string"

extension String {
    func getCharList() -> [Character] {
        var characters = [Character]()
        for character in self {
            characters.append(character)
        }
        return characters
    }
    subscript(singleSlice: Int) -> String {
        switch singleSlice{
        case ..<0:
            return String(self.getCharList().reversed()[singleSlice + 1])
        default:
            return String(self.getCharList()[singleSlice])
        }
    }
    subscript(start: Int, stop: Int) -> String {
        return String(self.getCharList()[start..<stop])
    }
    subscript(range: CountableRange<Int>) -> String {
        return String(self.getCharList()[range])
    }
    subscript(range: CountableClosedRange<Int>) -> String {
        return String(self.getCharList()[range])
    }
    subscript(range: PartialRangeThrough<Int>) -> String {
        return String(self.getCharList()[range])
    }
    subscript(range: CountablePartialRangeFrom<Int>) -> String {
        return String(self.getCharList()[range])
    }
    subscript(range: PartialRangeUpTo<Int>) -> String {
        return String(self.getCharList()[range])
    }
}

/* there's probably some higher level generic protocol or something
 I can swap in for all these ranges, but I don't know it. Still learning. */

print(s.getCharList())
print(s[1])
print(s[-1])
print(s[0, 5])
print(s[3...6])
print(s[2..<10])
print(s[...15])
print(s[2...])
print(s[..<15])
