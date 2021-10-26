Class {
	#name : #MicRealDumper,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream'
	],
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #'visit - section' }
MicRealDumper >> accept: aVisitor [

	^ aVisitor visitRaw: self
]

{ #category : #build }
MicRealDumper >> blockPrint: aMicText [

	| text |
	text := self classPrint: aMicText.
	text := text , ' "' , aMicText substring , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> classOf: aHeader on: st [
	st << aHeader class name; << ' new '
]

{ #category : #build }
MicRealDumper >> classPrint: aMicFigure [

	^ aMicFigure class asString
]

{ #category : #initialization }
MicRealDumper >> contents [ 

	^ stream contents
]

{ #category : #initialization }
MicRealDumper >> initialize [ 
	super initialize.
	stream := (String new: 10000) writeStream
]

{ #category : #build }
MicRealDumper >> parametersPrint: aDictionnary [

	| text lastKey |
	lastKey := aDictionnary keys last.
	text := 'parameters:'.
	aDictionnary keysAndValuesDo: [ :k :v |
		text := text , k ,'=', v.
		k = lastKey 
			ifFalse: [ 
				text := text , '&' ]].
	^ text
]

{ #category : #build }
MicRealDumper >> visit: aMicElement [

	^ aMicElement accept: self
]

{ #category : #'visit - section' }
MicRealDumper >> visitAnchor: aAnchor [

	| text |
	text := self classPrint: aAnchor.
	text := text , ' "' , aAnchor label , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitBold: aMicBold [

	^ self blockPrint: aMicBold
]

{ #category : #'visit - section' }
MicRealDumper >> visitComment: aComment [

	| text |
	text := self classPrint: aComment.
	text := text , ' "' , aComment text , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitFigure: aMicFigure [

	| text |
	text := (self classPrint: aMicFigure) , String space.
	text := text
	        , (self parametersPrint: aMicFigure arguments asDictionary).
	text := text , ' url:' , aMicFigure url asString.
	text := text , ' "' , aMicFigure substring , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitHeader: aHeader [
	
	stream << '('.
	self classOf: aHeader on: stream.
	stream << 'level: '.
	aHeader level printOn: stream.
	stream 
		<< '; ';
		<< 'header: '.
	aHeader header printOn: stream.
	stream << ')' 		
		 
	
]

{ #category : #'visit - section' }
MicRealDumper >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
]

{ #category : #'visit - section' }
MicRealDumper >> visitLink: aMicLink [

	| text |
	text := self classPrint: aMicLink.
	text := text , ' url:' , aMicLink url asString , ' "'
	        , aMicLink substring , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitMonospace: aMonospace [

	^ self blockPrint: aMonospace
]

{ #category : #'visit - section' }
MicRealDumper >> visitOrderedList: aOrderedList [

	^ self classPrint: aOrderedList
]

{ #category : #'visit - section' }
MicRealDumper >> visitParagraph: aParagraph [
	
	stream << '('.
	self classOf: aParagraph on: stream.
	stream << ')' 		
		 
	
]

{ #category : #'visit - section' }
MicRealDumper >> visitQuote: aQuote [

	| text |
	text := self classPrint: aQuote.
	text := text , ' "' , aQuote text , '"'.
	^ text
]

{ #category : #'visit - section' }
MicRealDumper >> visitRaw: aMicRaw [

	^ self blockPrint: aMicRaw
]

{ #category : #'visit - section' }
MicRealDumper >> visitStrike: aMicStrike [

	^ self blockPrint: aMicStrike
]

{ #category : #'visit - section' }
MicRealDumper >> visitTable: aTable [

	^ self classPrint: aTable
]

{ #category : #'visit - section' }
MicRealDumper >> visitText: aMicText [

	^ self blockPrint: aMicText
]

{ #category : #'visit - section' }
MicRealDumper >> visitUnorderedList: aUnorderedList [

	^ self classPrint: aUnorderedList
]
