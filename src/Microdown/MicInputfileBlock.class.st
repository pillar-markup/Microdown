"
I handle input file. 
Note that I should start a new line but I can end on the same line. So I may look like an inline element but I'm a block one.

```text
<!inputFile|path=Chapters/withStyle.md!>
```

Example:
```text
<!inputFile|path=https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/readme.md!>
```

Gives:
<!inputFile|path=https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/readme.md!>

"
Class {
	#name : 'MicInputfileBlock',
	#superclass : 'MicEnvironmentBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicInputfileBlock class >> tag [ 
	^ #inputFile
]

{ #category : 'visiting' }
MicInputfileBlock >> accept: aVisitor [

	aVisitor visitInputFile: self
]

{ #category : 'visiting' }
MicInputfileBlock >> closeMe [
	super closeMe.
	(arguments includesKey: #path)
		ifTrue: [self path: (MicResourceReference fromUri: (arguments at: #path)) ]
		ifFalse: [ self path: (MicResourceReference fromUri: 'error: inputFile should have a path argument')]
]

{ #category : 'accessing' }
MicInputfileBlock >> fileWithConfiguration: aConfiguration [
	"I search my file."
	self flag: 'can be better to use the MicPathResolver'.
	^ aConfiguration baseDirectory resolve: self path
]

{ #category : 'testing' }
MicInputfileBlock >> isRelativeFilePath [
	^ (self path beginsWith: '/') not
]

{ #category : 'accessing' }
MicInputfileBlock >> originalPath [
	^ self properties at: #originalPath ifAbsent: [ self path ]
]

{ #category : 'accessing' }
MicInputfileBlock >> path [
	
	^ self arguments at: #path  ifAbsent: [ 'path is absent' ]
]

{ #category : 'accessing' }
MicInputfileBlock >> path: aPath [
	
	arguments at: #'path' put: aPath
]

{ #category : 'accessing' }
MicInputfileBlock >> reference [
	^ self arguments at: #path
]

{ #category : 'accessing' }
MicInputfileBlock >> reference: aMicResourceReference [

	self arguments at: #path put: aMicResourceReference
]
