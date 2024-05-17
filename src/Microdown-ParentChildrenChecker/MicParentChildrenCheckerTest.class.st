Class {
	#name : 'MicParentChildrenCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-ParentChildrenChecker',
	#package : 'Microdown-ParentChildrenChecker'
}

{ #category : 'accessing' }
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

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> testComplexDocumentWithConfusedKidsAndOrphans [ 
    | checker document child1 child2 wrongChild orphan |

    "Initialize the parent-children relationship checker"
    checker := MicParentChildrenChecker new.

    "Parse a complex Microdown document"
    document := Microdown parse: '# Microdown Documentation Example

Welcome to the **Microdown Documentation**. This document serves as a tutorial and reference for creating rich markdown documents with various formatting options in Microdown.

## Introduction

Microdown allows you to write documentation directly in your Pharo environment, supporting standard markdown syntax and Pharo-specific enhancements.

### What is Markdown?

Markdown is a lightweight markup language with plain-text formatting syntax. It is designed so that it can be converted to HTML and many other formats.

## Text Formatting

Text in Microdown can be formatted in several ways:

- **Bold**: `**Bold text**` renders as **Bold text**
- _Italic_: `*Italic text*` renders as _Italic text_
- **_Combined Emphasis_**: `**_Bold and italic_**` renders as **_Bold and italic_**

## Lists

Microdown supports both ordered and unordered lists.

### Unordered List

- Item 1
- Item 2
  - Subitem 2.1
  - Subitem 2.2

### Ordered List

1. First item
2. Second item
   1. Subitem 2.1
   2. Subitem 2.2

## Links and Images

### Linking

This is how you create a [link](http://example.com).

### Images

Here''s how you embed an image:

![Alt text for the image](http://example.com/image.png)

## Code Blocks

You can add code blocks for code snippets, which are especially useful for programming documentation:

```smalltalk
Transcript show: ''Hello, world!'.

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
    self deny:  checker isOk


]

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> testDocumentWithConfusedKids [ 
    | checker document child1 child2  |

    "Initialize the parent-children relationship checker"
   

    "Parse a simple Microdown document"
	 checker := MicParentChildrenChecker new.
    document := Microdown parse: '# Microdown is quite cool
    ## Subheading 1
    Microdown enables rich text formatting.
    ## Subheading 2
    It’s also quite easy to use.'.

    "Manually access children and reassign to create a 'confused kid'"
    child1 := document children first. 
    child2 := document children second children first .
	 child2 basicParent: child1 . 
   


    "Run the checker on the modified document"
    checker check: document.
	
	 self deny: checker isOk .

    "Assert that the checker identifies the document as not OK due to confused relationships"


]

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> testSimpleDocumentIsWellFormed [ 

	| checker |
	checker := MicParentChildrenChecker new.
	checker check: self document.
	self deny: ( checker isOk)

]

{ #category : 'accessing' }
MicParentChildrenCheckerTest >> testSimpleDocumentWithOrphans [ 

	| brokenDocument visitor orphan |
	visitor := MicParentChildrenChecker new.
	brokenDocument := Microdown parse: '# Microdown is quite cool'.
	orphan := brokenDocument children first children first.
	orphan basicParent: nil.
	self assert: orphan parent isNil.

	visitor check: brokenDocument.

	self deny: visitor isOk

]
