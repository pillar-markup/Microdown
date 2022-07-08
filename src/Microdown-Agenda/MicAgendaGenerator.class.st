"
I generate HTML specificly for a calendar in HTML from a template and a microdown AST.
"
Class {
	#name : #MicAgendaGenerator,
	#superclass : #MicHTMLVisitor,
	#instVars : [
		'time',
		'scheduleTemplate'
	],
	#category : #'Microdown-Agenda'
}

{ #category : #template }
MicAgendaGenerator class >> scheduleTemplate: aNewLine [
	| newLine |
	newLine := aNewLine asString.
	^ 
'						<!-- Schedule Details -->', newLine,
'								<li class="schedule-details">', newLine,
'										<div class="block">', newLine,
'											<!-- time -->', newLine,
'											<div class="time">', newLine,
'												<i class="fa fa-clock-o"></i>', newLine,
'												<span class="time">{{TIME}}</span>', newLine,
'											</div>', newLine ,
'											<!-- Speaker -->', newLine,
'											<div class="speaker">', newLine,
'												<!-- <img src="images/speakers/speaker-thumb-one.jpg" alt="speaker-thumb-one"> -->', newLine,
'												<span class="name">{{SPEAKER}}</span>', newLine,
'											</div>', newLine,
'											<!-- Subject -->', newLine,
'											<div class="subject">{{SUBJECT}}</div>', newLine,
'											<!-- Venue -->', newLine,
'											<div class="venue">{{ROOM}}</div>', newLine,
'										</div>', newLine,
'								</li>'
]

{ #category : #initialization }
MicAgendaGenerator >> initialize [

	super initialize.
	time := ''.
]

{ #category : #accessing }
MicAgendaGenerator >> time [

	^ time
]

{ #category : #accessing }
MicAgendaGenerator >> time: aTime [

	time := aTime
]

{ #category : #visiting }
MicAgendaGenerator >> timePlus: aLength [

	| currentHours currentMins type addedTime |
	currentHours := ((self time substrings: 'h') at: 1) asNumber .
	currentMins := ((self time substrings: 'h') at: 2) .
	addedTime := aLength allButLast asNumber.
	type := aLength last.
	( type = $h ) ifTrue: [ self time: ((currentHours  + addedTime) asString, 'h', currentMins) ]
					  ifFalse: [ (currentMins asNumber + addedTime = 60) ifTrue: [ self time: ((currentHours  + 1) asString, 'h00' )].
									 (currentMins asNumber + addedTime > 60) ifTrue: [ self time: ((currentHours  + 1) asString, 'h', (currentMins asNumber + addedTime - 60) asString )]  ]
	
]

{ #category : #visiting }
MicAgendaGenerator >> visitAgenda: anAgenda [

	self visitChildrenOf: anAgenda
]

{ #category : #visiting }
MicAgendaGenerator >> visitBreak: aBreak [

	| length html |
	length := self time, ' - '.
	self timePlus: aBreak length.
	length := length, self time.

	html := (MustacheTemplate on: scheduleTemplate) value: { 
	'TIME' -> length trim.
	'SPEAKER' -> aBreak author.
	'SUBJECT' -> aBreak subject.
	'ROOM' -> aBreak room } asDictionary.
	canvas nextPutAll: html.
	canvas newLine.
]

{ #category : #visiting }
MicAgendaGenerator >> visitDay: aDay [

	canvas nextPutAll: aDay start.
	canvas newLine.
	self visitChildrenOf: aDay.
	canvas newLine
]

{ #category : #visiting }
MicAgendaGenerator >> visitSegment: aSegment [

	self time: aSegment start.
	scheduleTemplate := self class scheduleTemplate: canvas stream configuration newLine.
	self visitChildrenOf: aSegment.
]

{ #category : #visiting }
MicAgendaGenerator >> visitTalk: aTalk [

	| length html |
	length := self time, ' - '.
	self timePlus: aTalk length.
	length := length, self time.
	html := (MustacheTemplate on: scheduleTemplate) value: { 
	'TIME' -> length trim.
	'SPEAKER' -> aTalk author.
	'SUBJECT' -> aTalk subject.
	'ROOM' -> aTalk room } asDictionary.
	canvas nextPutAll: html.
	canvas newLine.
]
