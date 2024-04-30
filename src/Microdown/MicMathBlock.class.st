"
I'm a math environment. I'm a block it means that I start by a newline with character `$$` and optional parameters, and I finish by a line with the same characters. 
My body can be on multiple line and may contain LaTeX expressions.
In particular it means that my body does not contain nested elements.

Here is an example 

```
$$
V_i = C_0 - C_3
$$
```

produces 

$$
V_i = C_0 - C_3
$$

Now if you want to have label and references to an equation as in LaTeX you should prefix the parameter with % (else it will break on github).



```
$$ % label=theEq
V_i = C_0 - C_3
$$

See *@theEq@*
```


"
Class {
	#name : 'MicMathBlock',
	#superclass : 'MicSameStartStopMarkupBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicMathBlock >> accept: aVisitor [ 
 	^ aVisitor visitMath: self
]

{ #category : 'handle' }
MicMathBlock >> anchor [
	| anchor |
	anchor := self arguments 
		at: #anchor 
		ifAbsent: [ nil ].
	"for backward compatibility"
	anchor ifNil: [ anchor := self arguments at: #label ifAbsent: [ nil ] ].
	^ anchor 
]

{ #category : 'handle' }
MicMathBlock >> anchorElement: anAnchorReferenceBlock [

	arguments at: #anchor put: anAnchorReferenceBlock.
	arguments removeKey: #label ifAbsent: [].
]

{ #category : 'handle' }
MicMathBlock >> closeMe [ 

	super closeMe.
	self hasAnchor 
		ifTrue: [ 
			| anchor |
			anchor := MicAnchorReferenceBlock new.
			anchor bodyString: self anchor.
			self anchorElement: anchor.
			anchor basicParent: self. ]
	
]

{ #category : 'handle' }
MicMathBlock >> extractFirstLineFrom: aLine [

	| lineWithoutMarkup |
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	lineWithoutMarkup := lineWithoutMarkup withoutPrefix: '%'.
	arguments := MicArgumentList 
		split: lineWithoutMarkup.
	^ lineWithoutMarkup
]

{ #category : 'testing' }
MicMathBlock >> hasAnchor [
	^ arguments includesKey: #anchor
]

{ #category : 'markups' }
MicMathBlock >> lineStartMarkup [
	
	^ MathOpeningBlockMarkup
]
