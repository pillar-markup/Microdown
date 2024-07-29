"
I handle an input file e.g. `<!inputFile|path=Chapters/withStyle.md!>`. I should start on a new line but I can end on the same line. So I may look like an inline element but I'm a block one.

Note that my path can be resolved (See asMicResourceReference and MicFileResourceReference for more information how to resolve my path), when resolved the message `reference` return the resolved path (i.e.  to go from a relative to an absolute paths). 

```text
<!inputFile|path=Chapters/withStyle.md!>
```

Example:
```text
<!inputFile|path=https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/readme.md!>
```

Gives:
<!inputFile|path=https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/readme.md!>

***
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

{ #category : 'accessing' }
MicInputfileBlock >> fullNameString [

	^ self path fullName
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
