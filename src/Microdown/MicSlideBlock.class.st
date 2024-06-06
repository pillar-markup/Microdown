"
I'm a block element defining a slide. I expect a title and optionally a tag (to be able for example 
to have the same slide but on two different layouts and not emit both. 

```language=text
<!slide|title=This is a cool title&tag=nh5p

- a list of bullet
- bullet 2
- bullet 3
!>
```
"
Class {
	#name : 'MicSlideBlock',
	#superclass : 'MicEnvironmentBlock',
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'accessing' }
MicSlideBlock class >> tag [

	^ #slide
]

{ #category : 'accessing' }
MicSlideBlock >> accept: aVisitor [
	^ aVisitor visitSlide: self
]

{ #category : 'printing' }
MicSlideBlock >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' -- ' ; nextPutAll: self title
]

{ #category : 'accessing' }
MicSlideBlock >> tag [
	^ arguments at: 'tag' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
MicSlideBlock >> title [
	^ arguments at: 'title' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
MicSlideBlock >> title: aString [

	arguments at: #title put: aString
]
