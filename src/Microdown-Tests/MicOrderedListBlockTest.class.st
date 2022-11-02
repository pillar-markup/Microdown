"
I'm a test class for testing the behavior of ordered list blocks
"
Class {
	#name : #MicOrderedListBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #factory }
MicOrderedListBlockTest >> orderedListBlockClass [
	^ MicOrderedListBlock
]

{ #category : #functions }
MicOrderedListBlockTest >> orderedListWithTwoItemsBoldFirstSample [

	^ '
1. **_first_**
1. second
'
]

{ #category : #tests }
MicOrderedListBlockTest >> subjectClass [ 
	^ MicOrderedListBlock 
]

{ #category : #tests }
MicOrderedListBlockTest >> testEmbeddedUnordered [

	| source root list |
	source := '1. item 1
   - sublevel item 1
   - sublevel item 2
1. item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children second testText equals: 'item 2'.

	"item 1 + nested list"
	self assert: list children first children size equals: 2.

	self assert: list children first children first text equals: 'item 1'.

	self
		assert: list children first children second children first testText
		equals: 'sublevel item 1' "list item"
]

{ #category : #'tests - nested' }
MicOrderedListBlockTest >> testNestedLevel [

	| source root list item1 |
	source := 
'1. item 1
   6) sublevel
1. item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.

	item1 := list children first.
	self assert: item1 children first bodystring equals: 'item 1'.
	self assert: item1 class equals: MicListItemBlock.
	self assert: item1 nestedLevel equals: 1.

	"this is the inner list"
	self assert: item1 children second nestedLevel equals: 2.
	self assert: item1 children second class equals: MicOrderedListBlock.

	"this is the inner list first item"
	self
		assert: item1 children second children first children first bodystring 
		equals: 'sublevel'.
	self
		assert: item1 children second children first class
		equals: MicListItemBlock
]

{ #category : #'tests - nested' }
MicOrderedListBlockTest >> testNestedLevel2 [

	| source root list item1 sublevelItem |
	source := '1. item 1
   6) sublevel
      1. subsublevel
   7) sublevel2
1. item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.

	item1 := list children first.
	sublevelItem := item1 children second children first.

	"this is the inner list"
	self assert: item1 children second nestedLevel equals: 2.
	self assert: item1 children second class equals: MicOrderedListBlock.

	"this is the inner list first item"
	self
		assert: sublevelItem children first bodystring
		equals: 'sublevel'.
	self assert: sublevelItem class equals: MicListItemBlock.

	self
		assert: sublevelItem children second children first nestedLevel
		equals: 3.
	self
		assert: sublevelItem children second children first children first bodystring
		equals: 'subsublevel'
]

{ #category : #tests }
MicOrderedListBlockTest >> testNotSpawingNewParagraph [

	| root list |
	root := parser parse: '1. first item
   with a follow up 
   and another one. 
2. second item
   follow up of second item'.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list class equals: self orderedListBlockClass.
	self assert: list startIndex equals: 1.
	self assert: list children second testText equals: 'second item
follow up of second item'
]

{ #category : #tests }
MicOrderedListBlockTest >> testSingleLevelList2 [

	| source root list |
	source := '19. item 1
    expanded
7.  item 2'.
	root := parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children first testText equals: 'item 1
expanded'.
	self assert: list startIndex equals: 19
]

{ #category : #tests }
MicOrderedListBlockTest >> testSingleLevelList2WithNoIndent [

	"when we want a paragraph to be part of an item it should be indented "

	| source root list |
	source := '19. item 1
expanded as new paragraph
7.  item 2
    part of item2'.
	root := parser parse: source.
	self assert: root children size equals: 3.
	"two lists + one paragraph"
	list := root children first.
	self assert: list children size equals: 1.
	self assert: list children first testText equals: 'item 1'.
	self assert: list startIndex equals: 19.

	self
		assert: root children last children first testText
		equals: 'item 2
part of item2'
]

{ #category : #tests }
MicOrderedListBlockTest >> testSingleLevelListWithNormalNumbering [

	| root list |
	root := parser parse: '1. first item
2. second item'.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list class equals: self orderedListBlockClass.
	self assert: list startIndex equals: 1.
	self assert: list children second testText equals: 'second item'
]

{ #category : #tests }
MicOrderedListBlockTest >> testSingleLevelListWithNormalNumberingWithEmptyLines [

	| root list |
	root := parser parse: '1. first item



2. second item'.
	self assert: root children size equals: 1.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list class equals: self orderedListBlockClass.
	self assert: list startIndex equals: 1.
	self assert: list children second testText equals: 'second item'
]

{ #category : #tests }
MicOrderedListBlockTest >> testSingleLevelListWithStrangelyNumberedItems [

	| root list |
	root := parser parse: '11. item 1
2. item 2'.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list class equals: self orderedListBlockClass.
	self assert: list startIndex equals: 11.
	self assert: list children second testText equals: 'item 2'
]

{ #category : #tests }
MicOrderedListBlockTest >> testSpawingNewParagraph [

	| root |
	root := parser parse: '1. first item
   with a follow up
a new paragraph. 
2. second list first item
   follow up of second item'.
	self assert: root children size equals: 3.
	self
		assert: root children first children first testText
		equals: 'first item
with a follow up'.
	self assert: root children third startIndex equals: 2.
	self
		assert: root children third children first testText
		equals: 'second list first item
follow up of second item'
]

{ #category : #'tests - list' }
MicOrderedListBlockTest >> testUnOrderedListAPIToAccessText [

	| list |
	list := (self parser parse:
		         self orderedListWithTwoItemsBoldFirstSample) children first
		        children first.

	self assert: list class equals: MicListItemBlock.
	self assert: list nestedLevel equals: 1.
	self assert: list children first children first children first bodystring equals: 'first'
]
