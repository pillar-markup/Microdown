Class {
	#name : 'MicParentChildrenCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-ParentChildrenChecker',
	#package : 'Microdown-ParentChildrenChecker'
}

{ #category : 'tests' }
MicParentChildrenCheckerTest >> document [ 
	^ Microdown parse: '#Microdown is quite cool

Here is some code 

```language=Pharo&caption=Beautiful&anchor=Fig1
   1000 factorial / 999 factorial
```

Here is a figure and a link: [http://pharo.org](http://pharo.org).

![Pharologo](https://files.pharo.org/media/logo/logo.png size=80&anchor=figLogo.)



Here is a list:
- item 1
  1. sub item 1 
  3. sub item 2
- item 2


**Bold**, _italic_, `monospace`

In Pharo, Microdown supports hyperlinks to: 
- classes e.g., `Point`, 
- methodes e.g., `Point class`, `Point>>#setX:setY:`, and 
- packages e.g., `#''Microdown-Tests''` (for packages).

You can edit this file clicking on `ClySyntaxHelpMorph>>#rawMicrodownSyntax`.'.

]

{ #category : 'tests' }
MicParentChildrenCheckerTest >> testSimpleDocumentIsWellFormed [

	|  visitor |
	visitor := MicParentChildrenChecker new.
	self document accept: visitor. 
	self assert: visitor isOk.
	

	


]

{ #category : 'tests' }
MicParentChildrenCheckerTest >> testSimpleDocumentWithOrphans [

	| brokenDocument visitor orphan |
	visitor := MicParentChildrenChecker new.
	brokenDocument := Microdown parse: '# Microdown is quite cool'.
	orphan := brokenDocument children first children first.
	orphan basicParent: nil.
	self assert: orphan parent isNil.

	visitor visit: brokenDocument.

	self deny: visitor isOk
]
