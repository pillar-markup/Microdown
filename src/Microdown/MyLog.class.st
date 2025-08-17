"
I'm responsible for keeping a log of the development actions at the design level.
Too many times I do not remember what I did and why.
"
Class {
	#name : 'MyLog',
	#superclass : 'Object',
	#category : 'Microdown-DevLog',
	#package : 'Microdown',
	#tag : 'DevLog'
}

{ #category : 'ui - dialogs' }
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

{ #category : 'ui - dialogs' }
MyLog >> l2025_08_11 [

	^ '
## 2025 08 11 

#### Fix the visit of the paragraph
	Now it uses <p> as before. Foliage generation is working. 
	
	'
]

{ #category : 'possible todos' }
MyLog >> pt2025_08_16 [

	^ '
## 2025 08 16 

- Anchor Linker Use - Investigate why it is not used.
- Check with HTML exporter does not inherit from `MicDocumentWriter`
- Check with textualexport does not inherit from `MicDocumentWriter`
- MicCodeBlock API does not support the setting of text
- body: set does not set the lement as children in a parent children relation
- we should revisit all the parent/children and named instance variables
	- we have caption and captionElements. This would indicate that 
	elements are returned using xxxElements
	- code:/body: is then expecting a string
	- It means that bodyString: and bodyString are not good API.
	
	
'
]
