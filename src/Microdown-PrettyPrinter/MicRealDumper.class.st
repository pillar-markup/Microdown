Class {
	#name : #MicRealDumper,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream'
	],
	#category : #'Microdown-PrettyPrinter'
}

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
MicRealDumper >> visitUnorderedList: aUnorderedList [

	^ self classPrint: aUnorderedList
]
