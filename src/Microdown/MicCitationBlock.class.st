"
A citation is an inline element that represents a bibliography reference, such as in LaTeX.
The bibliography will be able to extract its entries from the reference in the citation.

```language=text
this is a text with a {!citation|ref=Duca99a!}
```
"
Class {
	#name : 'MicCitationBlock',
	#superclass : 'MicAnnotationBlock',
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'accessing' }
MicCitationBlock class >> key [
	^ 'ref'
]

{ #category : 'accessing' }
MicCitationBlock class >> tag [

	^ #citation
]

{ #category : 'visiting' }
MicCitationBlock >> accept: aVisitor [
	aVisitor visitCitation: self
]

{ #category : 'accessing' }
MicCitationBlock >> ref [
	^ arguments at: 'ref' ifAbsent: [ '' ]
]
