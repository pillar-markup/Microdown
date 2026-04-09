"
I check that methods in code blocks have an empty line after the selector when there is no comment.

Example of incorrect method (no comment, no empty line):

```
goodWordFor: aString 
      | pair |
      pair := pairs detect: [ :each | each key = aString ].
      ^ pair value
```

Example of correct method (no comment, empty line after selector):

```
goodWordFor: aString 
	
      | pair |
      pair := pairs detect: [ :each | each key = aString ].
      ^ pair value
```

Example of correct method (with comment, no empty line needed):
  
```
goodWordFor: aString 
      ""there is a comment""
      | pair |
      pair := pairs detect: [ :each | each key = aString ].
      ^ pair value
```
"
Class {
	#name : 'MicMethodStructureChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-MethodStructure',
	#package : 'Microdown-Rules',
	#tag : 'MethodStructure'
}

{ #category : 'public - name' }
MicMethodStructureChecker class >> checkerName [

	^ 'MethodStructure'
]

{ #category : 'configuration' }
MicMethodStructureChecker >> configureFrom: aConfiguration [
	^ self
]

{ #category : 'as yet unclassified' }
MicMethodStructureChecker >> resultHeaderStrings [
    ^ #('Method Structure')
]

{ #category : 'visiting' }
MicMethodStructureChecker >> visitCode: aMicCode [
	| lines firstLine secondLine |
	lines := aMicCode body lines.
	lines size < 2 ifTrue: [ ^ self ].
	firstLine := lines first.
	secondLine := lines second.
	"If the second line begins with a comment, that's correct."
	(secondLine trimLeft beginsWith: '"') ifTrue: [ ^ self ].
	"If the second line is empty, it's correct."
	secondLine trimLeft isEmpty ifTrue: [ ^ self ].
	"ifelse, theres's a blank line missing after the selector"
	results  add: (MicMethodStructureResult new 
		micElement: aMicCode;
		inFile: aMicCode fromFile;
		detail: firstLine;
		yourself 
	)
]
