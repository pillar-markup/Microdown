"
A citation is an inline element that represents a bibliography reference as in LaTeX for example.
The bibliography will be able to extract its entries from the reference in the citation.

```
this is a text with a {!citation|ref=Duca99a!}
```

"
Class {
	#name : #MicCitationBlock,
	#superclass : #MicAnnotationBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicCitationBlock class >> tag [

	^ #citation
]

{ #category : #visiting }
MicCitationBlock >> accept: aVisitor [
	aVisitor visitCitation: self
]

{ #category : #accessing }
MicCitationBlock >> ref [
	^ arguments at: 'ref' ifAbsent: [ '' ]
]
