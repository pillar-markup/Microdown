Extension { #name : 'String' }

{ #category : '*Microdown-ReferenceChecker' }
String >> allRangesOfSubstringTable: aSubstring [
    "Return a collection of positions right after each occurrence of aSubstring ends within the receiver."

    | positions start index |
    positions := OrderedCollection new.
    start := 1.

    [ (index := self findString: aSubstring startingAt: start) > 0 ] whileTrue: [
        positions add: (index + aSubstring size).
        start := index + 1.
    ].

    ^ positions
]
