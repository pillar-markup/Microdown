Class {
	#name : 'MicCodeTabsRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-Old',
	#package : 'Microdown-Rules',
	#tag : 'Old'
}

{ #category : 'action' }
MicCodeTabsRule >> findFirstUncorrectIndent: methodBody [

	methodBody lines withIndexDo: [ :line :index |
			| indentCount |
			indentCount := self indentCountOf: line.
			indentCount \\ 3 ~= 0 ifTrue: [ ^ index ] ].

	^ nil
]

{ #category : 'action' }
MicCodeTabsRule >> indentCountOf: aLine [
    | firstCharIndex |
    firstCharIndex := aLine findFirst: [ :char | char ~= Character space ].

    firstCharIndex = 0
        ifTrue: [ ^ aLine size ]
        ifFalse: [ ^ firstCharIndex - 1 ].

]
