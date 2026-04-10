Extension { #name : 'String' }

{ #category : '*Microdown-Rules' }
String >> isCapitalized [
	"Return true if the first letter is capitalized"
	
	"'abc' isCapitalized >>> false"
	"'Abc' isCapitalized >>> true"
	
	self ifEmpty: [ ^ false ].
	^ self first isUppercase
]
