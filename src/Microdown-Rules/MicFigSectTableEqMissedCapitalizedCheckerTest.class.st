Class {
	#name : 'MicFigSectTableEqMissedCapitalizedCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'ck'
	],
	#category : 'Microdown-Rules-BogusImplementation',
	#package : 'Microdown-Rules',
	#tag : 'BogusImplementation'
}

{ #category : 'tests' }
MicFigSectTableEqMissedCapitalizedCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'example1WithMistake.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
Pharo is cool

Spec uses a sub presenter
```
	this is a code
```
' ].

	file := fileSystem workingDirectory / 'example2WithMistake.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '## Bar
Pharo is **cool**

sub-presenter is not correct.
```
	this is a code 2
```
' ]
]

{ #category : 'tests' }
MicFigSectTableEqMissedCapitalizedCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.


]

{ #category : 'tests' }
MicFigSectTableEqMissedCapitalizedCheckerTest >> testCheckerFindFigureMistackeInTitle [

	| doc |
	self skip.
	doc := Microdown parse: '# figure 1.1'.
	ck visit: doc.
	self assert: ck errors size equals: 1
	"this is not that simple because figure 2.1 is a problem but it should be written Figure @*anchor*@ first 
	then the figure should be considered as correct. So all these tests are wrong in fact."
]
