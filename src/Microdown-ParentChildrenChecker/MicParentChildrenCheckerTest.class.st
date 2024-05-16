Class {
	#name : 'MicParentChildrenCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-ParentChildrenChecker',
	#package : 'Microdown-ParentChildrenChecker'
}

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> document [ [ 
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
]

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> testComplexDocumentWithConfusedKidsAndOrphans [ [
    | checker document child1 child2 wrongChild orphan |

    "Initialize the parent-children relationship checker"
    checker := MicParentChildrenChecker new.

    "Parse a complex Microdown document"
    document := Microdown parse: '# Main Heading
    Microdown supports multiple features.
    ## Subheading 1
    It allows rich text.
    ### Sub-Subheading 1.1
    Nested structures are its forte.
    ## Subheading 2
    Easy to learn and use.
    ### Sub-Subheading 2.1
    Documentation is key.
    ### Sub-Subheading 2.2
    Community support is robust.'.

    "Create confused kids: Misassign a sub-subheading to a different subheading"
    child1 := document children second children second. "Assuming this is Sub-Subheading 1.1"
    child2 := document children third. "Assuming this is Subheading 2"
    wrongChild := child1 children first. "Content of Sub-Subheading 1.1"
    wrongChild basicParent: child2. "Incorrectly setting it to Subheading 2"

    "Create an orphan: Detach a sub-subheading without assigning a new parent"
    orphan := document children third children last. "Assuming this is Sub-Subheading 2.2"
    orphan basicParent: nil.

    "Verify incorrect setups before checking"
    self assert: (wrongChild parent = child2).
    self assert: orphan parent isNil.

    "Run the checker on the modified document"
    checker check: document.

    "Assert that the checker identifies the document as not OK"
    self deny: checker isOk
]

]

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> testDocumentWithConfusedKids [ [
    | checker document child1 child2 wrongChild |

    "Initialize the parent-children relationship checker"
    checker := MicParentChildrenChecker new.

    "Parse a simple Microdown document"
    document := Microdown parse: '# Microdown is quite cool
    ## Subheading 1
    Microdown enables rich text formatting.
    ## Subheading 2
    It’s also quite easy to use.'.

    "Manually access children and reassign to create a 'confused kid'"
    child1 := document children first. "Assuming this is the heading for Subheading 1"
    child2 := document children second. "Assuming this is the heading for Subheading 2"
    
    "Simulate a confusion: child under 'Subheading 1' wrongly set to be a child of 'Subheading 2'"
    wrongChild := child1 children first. "This should be part of Subheading 1 content"
    wrongChild basicParent: child2. "Mistakenly setting it to Subheading 2"
    
    "Verify the structure before checking"
    self assert: (wrongChild parent = child2).

    "Run the checker on the modified document"
    checker check: document.

    "Assert that the checker identifies the document as not OK due to confused relationships"
    self deny: checker isOk
]

]

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> testSimpleDocumentIsWellFormed [ [

	| checker |
	checker := MicParentChildrenChecker new.
	checker check: self document.
	self assert: checker isOk
]
]

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> testSimpleDocumentWithOrphans [ [

	| brokenDocument visitor orphan |
	visitor := MicParentChildrenChecker new.
	brokenDocument := Microdown parse: '# Microdown is quite cool'.
	orphan := brokenDocument children first children first.
	orphan basicParent: nil.
	self assert: orphan parent isNil.

	visitor check: brokenDocument.

	self deny: visitor isOk
]
]
