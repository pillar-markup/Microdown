Class {
	#name : 'MicCodeCorrectTabs',
	#superclass : 'MicAbstractSanitizer',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'as yet unclassified' }
MicCodeCorrectTabs >> contentWithoutIndentOf: aLine [
    "Retourne la ligne sans les espaces de début."
    | firstCharIndex |
    firstCharIndex := aLine findFirst: [ :char | char ~= Character space ].

    firstCharIndex = 0
        ifTrue: [ ^ '' ].
    ^ aLine copyFrom: firstCharIndex to: aLine size.
]

{ #category : 'as yet unclassified' }
MicCodeCorrectTabs >> correctSpacesByTabs: methodBody [

	^ String cr join: (methodBody lines collect: [ :line |
				   | indentCount tabs spaces content |
				   indentCount := MicCodeTabsRule new.
				   indentCount indentCountOf: line.
				   content := self contentWithoutIndentOf: line.

				   tabs := indentCount // 3.
				   spaces := indentCount \\ 3.

				   (String new: tabs withAll: Character tab)
				   , (String new: spaces withAll: Character space) , content ])
]

{ #category : 'as yet unclassified' }
MicCodeCorrectTabs >> sanitize: methodBody [

	^ String cr join: (methodBody lines collect: [ :line |
				   | indentCount tabs spaces content |
				   indentCount := MicCodeTabsRule new indentCountOf: line.
				   
				   content := self contentWithoutIndentOf: line.

				   tabs := indentCount // 3.
				   spaces := indentCount \\ 3.

				   (String new: tabs withAll: Character tab)
				   , (String new: spaces withAll: Character space) , content ])
]
