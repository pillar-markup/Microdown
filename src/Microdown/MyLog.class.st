"
I'm responsible for keeping a log of the development actions at the design level.
Too many times I do not remember what I did and why.
"
Class {
	#name : 'MyLog',
	#superclass : 'Object',
	#category : 'Microdown',
	#package : 'Microdown'
}

{ #category : 'as yet unclassified' }
MyLog >> l2025_08_08 [

	^ '
## 2025 08 08 

#### Started this log	
#### Fix the rendering of paragraphs. 

The problem was that when two consecutive paragraphs were rendered we could not see the split.
https://github.com/pillar-markup/Microdown/issues/957 
It was due to a lack of <p> or newline. 

I decided to go for an extra newLine but it can be a bad choice. 

```
visitParagraph: aParagraph

	canvas newLine.
	super visitParagraph: aParagraph.
	"Introduce an extra new line to address problem of merged rendered paragraph. 
	I did not reintroduce the <p> below because I do not remember why it was 
	cancel. May be it was generating too many <p> 
	Now it may happen that for intra block element tests <p> was generated
	while in a normal setup (since the intrablock elements will be inside
	a large paragraph) it will not be a problem. 
	
	So this issue should be further investigated."
	canvas newLine.
	"canvas tag
		name: ''p'';
		with: [  ]"
```
	
	'
]
