Class {
	#name : 'MicSummarizerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'tests' }
MicSummarizerTest >> createListOfFile [

	| q |
	q := Array new: 3.
	q at: 1 put: self generateFilesystemExample1;
	at: 2 put: self generateFilesystemExample2;
	at: 3 put: self generateFilesystemExample3.
	^ q
]

{ #category : 'tests' }
MicSummarizerTest >> createListOfMicRootBlock [

	| q singleSummarizer |
	q := Array new: 3.
	singleSummarizer := MicSingleSummarizer new.
	q
		at: 1 put: (singleSummarizer summarize: (Microdown parse:
							  self generateFilesystemExample1 asFileReference contents));
		at: 2 put: (singleSummarizer summarize: (Microdown parse:
							  self generateFilesystemExample2 asFileReference contents));
		at: 3 put: (singleSummarizer summarize: (Microdown parse:
							  self generateFilesystemExample3 asFileReference contents)).
	^ q
]

{ #category : 'tests' }
MicSummarizerTest >> generateFilesystemExample1 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "8 January 2019"
}
# A Cool Story

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!
' ].

	^ file
]

{ #category : 'tests' }
MicSummarizerTest >> generateFilesystemExample2 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "22 January 2019"
}
# Pharo is cool

If you are either a beginner or an expert in object-oriented programming, _this MOOC_ will change the way you program with objects: come and learn or rediscover _object-oriented programming_ with Pharo!

Pharo is a pure _object-oriented programming language_ in the tradition of Smalltalk. It offers a unique developing experience in constant interaction with live objects. Pharo is elegant, fun to use and very powerful. It is very easy to learn and enables to understand advanced concept in a natural way. When programming in Pharo, you are immersed in a world of live objects. You have immediate feedback at any moment of your development on objects representing web applications, code itself, graphics, network. More…
' ].

	^ file
]

{ #category : 'tests' }
MicSummarizerTest >> generateFilesystemExample3 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "29 January 2018"
}
# Mooc Pharo

Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects). 

The Pharo Mooc is fully dubbed in french and english. It comes with subtitles in Japanese, english, french and spanish. This web site contains all the material of this Mooc in free access.

In addition, in average every 18 months the Mooc is proposed and run on the France Université Numérique platform (Even if the platform is french the mooc is run in both languages). 

When you participate to the mooc you get access to the quizz and the credit validation. 
' ].

	^ file
]

{ #category : 'as yet unclassified' }
MicSummarizerTest >> htmlBodyTest [

	^ '<body><main role="main">
<h1><a target="_blank" href="''''/''''">A Cool Story</a></h1>
<p>Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no ...</p>
<h1><a target="_blank" href="''''/''''">Pharo is cool</a></h1>
<p>If you are either a beginner or an expert in object-oriented programming, _this MOOC_ will ...</p>
<h1><a target="_blank" href="''''/''''">Mooc Pharo</a></h1>
<p>Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects).</p>
<ul>
<li><a target="_blank" href="http://pharo.org/">January 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2014</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2015</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2016</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2017</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2018</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2019</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2020</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2021</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2022</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2023</a></li>
<li><a target="_blank" href="http://pharo.org/">January 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">February 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">March 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">April 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">May 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">June 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">July 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">August 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">September 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">October 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">November 2024</a></li>
<li><a target="_blank" href="http://pharo.org/">December 2024</a></li>
</ul></main></body>'

]

{ #category : 'tests' }
MicSummarizerTest >> testGroupByDate [

	| summary group |
	summary := self createListOfMicRootBlock.
	group := MicSummarizer new group: summary byDate: (Date newDay: 1 month: 'January'  year: 2019).
	
	self assert: group size equals: 2.
]

{ #category : 'tests' }
MicSummarizerTest >> testSummarize [

	| summary |
	summary := MicSummarizer new summarize: self createListOfMicRootBlock.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 6
]

{ #category : 'tests' }
MicSummarizerTest >> testSummarizeFile [

	| summary |
	summary := MicSummarizer new summarizeFile: self createListOfFile.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 6
]
