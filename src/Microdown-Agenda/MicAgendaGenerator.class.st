"
I generate HTML specificly for a calendar in HTML from a template and a microdown AST.
"
Class {
	#name : #MicAgendaGenerator,
	#superclass : #MicHTMLVisitor,
	#instVars : [
		'parentFile',
		'time',
		'talkTemplate',
		'agendaTemplate',
		'daysHeadersBlock',
		'daysTalks',
		'dayTalksTemplate',
		'talks',
		'daysNumber',
		'dayHeaderBlockTemplate'
	],
	#category : #'Microdown-Agenda'
}

{ #category : #template }
MicAgendaGenerator class >> agendaTemplate: aNewLine [
	| newLine |
	newLine := aNewLine asString.
	^ 
'<!DOCTYPE html>', newLine,
'<html lang="en">', newLine,
'<head>', newLine, newLine,

'  <!-- Basic Page Needs', newLine,
'  ================================================== -->', newLine,
'  <meta charset="utf-8">', newLine,
'  <title>PharoDays 2022</title>', newLine,
  '<!-- Mobile Specific Metas
  ================================================== -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Event and Conference Html5 Template">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
  <meta name="author" content="Themefisher">
  <meta name="generator" content="Themefisher Eventre HTML Template v1.0">
  
  <!-- PLUGINS CSS STYLE -->
  <!-- Bootstrap -->
  <link href="https://days.pharo.org/plugins/bootstrap/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://days.pharo.org/plugins/font-awsome/css/font-awesome.min.css" rel="stylesheet">
  <!-- Magnific Popup -->
  <link href="https://days.pharo.org/plugins/magnific-popup/magnific-popup.css" rel="stylesheet">
  <!-- Slick Carousel -->
  <link href="https://days.pharo.org/plugins/slick/slick.css" rel="stylesheet">
  <link href="https://days.pharo.org/plugins/slick/slick-theme.css" rel="stylesheet">
  <!-- CUSTOM CSS -->
  <link href="https://days.pharo.org/css/style.css" rel="stylesheet">
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A==" crossorigin="" />
  
  <!-- FAVICON -->
  <link href="https://files.pharo.org/media/logo/icon-256-256.ico" rel="shortcut icon">',


'</head>', newLine, newLine,

'<body class="body-wrapper">', newLine, newLine,

'<section class="section schedule" id="schedule">', newLine,
'	<div class="container">', newLine,
'		<div class="row">', newLine,
'			<div class="col-12">', newLine,
'				<div class="section-title">', newLine,
'					<h3>Pharo Days <span class="alternate">Schedule</span></h3>', newLine,
'					<p>Pharo Days will held on 3 and 4 march 2022.</p>', newLine,
'					<p>We also organize a <b>workshop</b> before the conference for people who wish to discover', newLine,
'					 Pharo and <b>how Pharo can help in your day to day life</b>.</p>', newLine,
'					</p><br><i class="far fa-newspaper"></i>', newLine,
'					<p>Abstracts of talks and hands-on are available on <b><a href="./abstracts.html">the asbtracts page</a></b></p>', newLine,
'				</div>', newLine,
'			</div>', newLine,
'		</div>', newLine,
'		<div class="row">', newLine,
'			<div class="col-12">', newLine,
'				<div class="schedule-tab">', newLine,
'					<ul class="nav nav-pills text-center">', newLine,
										
'							{{{DAYSBLOCK}}}', newLine,				
						
'					</ul>', newLine,
'				</div>', newLine,
'				<div class="schedule-contents bg-schedule">', newLine,
'					<div class="tab-content" id="pills-tabContent">', newLine,
									
'							{{{DAYS}}}', newLine,			
						
'					</div>', newLine,
'				</div>', newLine, newLine,
				
'			</div>', newLine,
'		</div>', newLine,
'	</div>', newLine,
'</section>', newLine, newLine,

'<!--====  End of Schedule  ====-->', newLine, newLine,

'</body>', newLine, newLine,

'</html>'
]

{ #category : #template }
MicAgendaGenerator class >> dayHeaderBlockTemplate: aNewLine [

	| newLine |
	newLine := aNewLine asString.
	^ 
' 					  <li class="nav-item">', newLine,
'					    <a class="nav-link active" href="#{{{NUMBER}}}" data-toggle="pill">', newLine,
'					    	{{{DAYNUMBER}}}', newLine,
'					    	<span>{{{DATE}}}</span>', newLine,
'					    </a>', newLine,
'					  </li>', newLine
]

{ #category : #template }
MicAgendaGenerator class >> dayTalksTemplate: aNewLine [

	| newLine |
	newLine := aNewLine asString.
	^ 
'				<div class="schedule-contents bg-schedule">', newLine,
'					<div class="tab-content" id="pills-tabContent">', newLine,
'					  <div class="tab-pane fade show active schedule-item" id="{{{DAYNUMBER}}}">', newLine,
'					  	<!-- Headings -->', newLine,
'					  	<ul class="m-0 p-0">', newLine,
'					  		<li class="headings">', newLine,
'					  			<div class="time">Time</div>', newLine,
'					  			<div class="speaker">Speaker</div>', newLine,
'					  			<div class="subject">Subject</div>', newLine,
'					  			<div class="venue">Venue</div>', newLine,
'					  		</li>', newLine,
'							{{{SCHEDULES}}}', newLine,
'					  </ul>', newLine,
'					  </div>', newLine
]

{ #category : #template }
MicAgendaGenerator class >> talkTemplate: aNewLine [
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

{ #category : #visiting }
MicAgendaGenerator >> build: aScheduleFile [
	
	| file fileReference|
	parentFile := aScheduleFile parent.
	file := Microdown parse: aScheduleFile contents.
	fileReference := (parentFile / 'GeneratedHTML/Schedule.html') asFileReference.
	fileReference ensureDelete.
	self visit: file.
	fileReference writeStreamDo: [ :stream | stream nextPutAll: self contents ]
]

{ #category : #initialization }
MicAgendaGenerator >> initialize [

	super initialize.
	time := ''.
	daysTalks := ''.
	daysHeadersBlock := ''.
	talks := ''.
	daysNumber := 0.
]

{ #category : #visiting }
MicAgendaGenerator >> templateInitialization [

	agendaTemplate := parentFile / 'Template/agendaTemplate.mustache' .
	dayHeaderBlockTemplate := parentFile / 'Template/dayHeaderBlockTemplate.mustache'.
	dayTalksTemplate :=parentFile / 'Template/dayTalksTemplate.mustache'.
	talkTemplate := parentFile / 'Template/talkTemplate.mustache'.
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

	| currentHours currentMins addedTime nbHours |
	currentHours := ((self time substrings: 'h') at: 1) asNumber .
	currentMins := ((self time substrings: 'h') at: 2) .
	addedTime := aLength allButLast asNumber.
	nbHours := addedTime // 60.
	addedTime := addedTime - (nbHours * 60).
	(currentMins asNumber + addedTime = 60 or: currentMins asNumber + addedTime = 0) 
			ifTrue: [ (currentMins asNumber + addedTime = 60) 
					ifTrue: [ ^ self time: ((currentHours  + nbHours + 1) asString, 'h00') ]
					ifFalse: [ ^ self time: ((currentHours  + nbHours) asString, 'h00') ] ]
			ifFalse: [ (currentMins asNumber + addedTime > 60) 
					ifTrue:[ ^ self time: ((currentHours  + nbHours + 1) asString, 'h', (currentMins asNumber + addedTime - 60) asString)] 
					ifFalse:[ ^ self time: ((currentHours  + nbHours) asString, 'h', (currentMins asNumber + addedTime) asString)]]
	
]

{ #category : #visiting }
MicAgendaGenerator >> visitAgenda: anAgenda [
	
	| agenda |
	self templateInitialization.
	self visitChildrenOf: anAgenda.
	agenda := (MustacheTemplate on: agendaTemplate) value: {
	'NUMBERDAY' -> daysNumber. 
	'DAYSBLOCK' -> daysHeadersBlock.
	'DAYS' -> daysTalks } asDictionary.
	canvas nextPutAll: agenda
]

{ #category : #visiting }
MicAgendaGenerator >> visitBreak: aBreak [

	| length talk |
	length := self time, ' - '.
	self timePlus: aBreak length.
	length := length, self time.
	
	talk := (MustacheTemplate on: talkTemplate) value: { 
	'TIME' -> length trim.
	'SPEAKER' -> aBreak author.
	'SUBJECT' -> aBreak subject.
	'ROOM' -> aBreak room } asDictionary.
	talks := talks, talk.
]

{ #category : #visiting }
MicAgendaGenerator >> visitDay: aDay [

	| day dayBlock number numberDay active|
	daysNumber := daysNumber + 1.
	active := ''.
	(daysNumber = 1) 
				ifTrue: [active := 'show active']
				ifFalse: [active := ''].
	number := 'day', daysNumber asString.
	numberDay := 'Day-0', daysNumber asString.
	dayBlock := (MustacheTemplate on: dayHeaderBlockTemplate) value: { 
	'NUMBER' -> number.
	'ACTIVE' -> active.
	'DAYNUMBER' -> numberDay.
	'DATE' -> aDay start } asDictionary.
	daysHeadersBlock  := daysHeadersBlock, dayBlock.
	self visitChildrenOf: aDay.
	day := (MustacheTemplate on: dayTalksTemplate) value: { 
	'DAYNUMBER' -> number.
	'ACTIVE' -> active.
	'SCHEDULES' -> talks asString } asDictionary.
	daysTalks := daysTalks, day.
	talks := ''.
]

{ #category : #visiting }
MicAgendaGenerator >> visitSegment: aSegment [

	self time: aSegment start.
	talkTemplate := parentFile / 'Template/talkTemplate.mustache' contents.
	self visitChildrenOf: aSegment.
]

{ #category : #visiting }
MicAgendaGenerator >> visitTalk: aTalk [

	| length talk |
	length := self time, ' - '.
	self timePlus: aTalk length.
	length := length, self time.
	
	talk := (MustacheTemplate on: talkTemplate) value: { 
	'TIME' -> length trim.
	'SPEAKER' -> aTalk author.
	'SUBJECT' -> aTalk subject.
	'ROOM' -> aTalk room } asDictionary.
	talks := talks, talk.
]
