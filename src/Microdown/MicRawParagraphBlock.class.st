"
I'm a block level element that represent contents that will never be interpreted.
- Contents on the first line is ignored.
- Contents starts from the following line after the `{{{`

Here is a test illustrating such behavior.

```
testFirstLineAfterMarkupShouldBeIgnored
	""contents starts on the following line of the {{{""
	| root |
	root := parser parse: '{{{ blabla
**Hello is ... cut for real

a paragraph on two lines**
}}}'.

	self assert: root children first bodyString equals: '**Hello is ... cut for real

a paragraph on two lines**'.
```	
"
Class {
	#name : 'MicRawParagraphBlock',
	#superclass : 'MicStartStopMarkupBlock',
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
	^ aVisitor visitRawParagraph: self
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
