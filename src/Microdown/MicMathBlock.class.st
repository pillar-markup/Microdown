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
MicMathBlock >> extractFirstLineFrom: aLine [

	| lineWithoutMarkup |
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	lineWithoutMarkup := lineWithoutMarkup withoutPrefix: '%'.
	arguments := MicArgumentList 
		split: lineWithoutMarkup.
	^ lineWithoutMarkup
]

{ #category : 'markups' }
MicMathBlock >> lineStartMarkup [
	
	^ MathOpeningBlockMarkup
]
