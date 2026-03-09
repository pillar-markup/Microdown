"
I'm a block level that handle html tag.
For this to work tag should start at the beginning of the line. 
I can contain nested tags and my body can contain microdown elements that are then interpreted.


```
| mic |
	mic := (parser parse: '<title> 
No idea what it is :)
</title>') children first.
	self assert: mic class equals: MicRawParagraphBlock. 
	self assert: mic label equals: 'title'.
	self assert: mic children first class equals: MicParagraphBlock
```

```
testRawParagraphCanBeNested
	| children |
	children := (parser parse: '<title> 
No idea what it is :)

<button>
hkhkjhkj
</button>
</title>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicRawParagraphBlock. 
	self assert: children first label equals: 'title'.
	self assert: children first children size equals: 2. 
	self assert: children first children first class equals: MicParagraphBlock.
	self assert: children first children second label  equals: 'button'.
	self assert: children first children second class  equals: MicRawParagraphBlock.
```
"
Class {
	#name : 'MicRawParagraphBlock',
	#superclass : 'MicNestedMarkupBlock',
	#instVars : [
		'label',
		'argumentsString'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'public' }
MicRawParagraphBlock class >> alternateBlockClassFor: aLine [
	"We do not want to have extention for MicRawParaphTag"
	
	^ self 
]

{ #category : 'visiting' }
MicRawParagraphBlock >> accept: aVisitor [

	aVisitor visitRawParagraph: self
]

{ #category : 'activation' }
MicRawParagraphBlock >> argumentString [
	^ argumentsString
]

{ #category : 'handle' }
MicRawParagraphBlock >> extractFirstLineFrom: aLine [
	"we got < tag ...x > foo bar or < tag ...x and we return tag ...x "
	
	| splits |
	firstLine := aLine copyFrom: self lineStartMarkup size to: aLine size.
	firstLine := firstLine trimBoth.
	firstLine := firstLine copyFrom: 1 to: firstLine size -1.
	
	splits := firstLine splitOnFirst: $>.
	splits second isNotEmpty
		ifTrue: [ "here we p>Blo and we discard Blo"
					label := splits first ].
	
	"now we may have <p src='whatever' so we split again"
	splits := splits first splitOnFirst: Character space.
	label := splits first.
	splits second isNotEmpty 
		ifTrue: [ argumentsString := splits second ].
	^ firstLine
]

{ #category : 'testing' }
MicRawParagraphBlock >> hasArguments [
	^ argumentsString isNotEmpty
]

{ #category : 'initialization' }
MicRawParagraphBlock >> initialize [

	super initialize.
	argumentsString := ''
]

{ #category : 'accessing' }
MicRawParagraphBlock >> label [
	^ label
]

{ #category : 'markups' }
MicRawParagraphBlock >> lineStopMarkup [

	^ '</', label, '>'
]

{ #category : 'printing' }
MicRawParagraphBlock >> printOn: aStream [ 

	super printOn: aStream.
	aStream << '(' ;
		<< label ;
		<< ')'
]
