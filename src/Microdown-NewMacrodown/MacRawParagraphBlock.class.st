"
This class is copied as it was from Macrodown package.
In particular I do not really get how the plain HTML is detected. It is a new top level block or an inline block?

It looks like the MacrodownParser is doing the following: 

```
blockStarterClassFrom: line

	self flag: #HACK. ""This is a special case because it collides with environment""
	(MacRawParagraphBlock matchesComment: line) 
		ifTrue: [ ^ self nonMatchedBlockClassFor: line ]. 
		
	^ super blockStarterClassFrom: line
```

It would have been nice to know it. I would have changed the syntax for environment. 



A raw paragraph block is a block that containes raw content (e.g. plain HTML)
"
Class {
	#name : 'MacRawParagraphBlock',
	#superclass : 'MicParagraphBlock',
	#category : 'Microdown-NewMacrodown',
	#package : 'Microdown-NewMacrodown'
}

{ #category : 'visiting' }
MacRawParagraphBlock >> accept: aVisitor [

 	^ aVisitor visitRawParagraph: self
]

{ #category : 'parse support' }
MacRawParagraphBlock >> closeMe [

	self children: { 
		MicRawBlock 
			from: 1 
			to: text size 
			withSubstring: text }
]
